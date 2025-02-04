# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Participant do
  let!(:participant) { create(:participant) }

  describe 'update_scoreboard' do
    before do
      allow(ScoreboardService).to receive(:update)
    end

    it 'tells the scoreboard to add on create with number' do
      create(:participant)
      expect(ScoreboardService).to have_received(:update)
        .with(with: instance_of(described_class), type: :add)
    end

    it 'does not tell the scoreboard to add on create without number' do
      create(:participant, number: nil)
      expect(ScoreboardService).not_to have_received(:update)
    end

    it 'tells the scoreboard to add when number is set' do
      new_participant = create(:participant, number: nil)
      new_participant.update(number: 999)
      expect(ScoreboardService).to have_received(:update)
        .with(with: new_participant, type: :add)
    end

    it 'tells the scoreboard to update on update' do
      participant.update(name: 'Padington Bear')
      expect(ScoreboardService).to have_received(:update).with(with: participant)
    end

    it 'tells the scoreboard to remove on destroy' do
      participant.destroy
      expect(ScoreboardService).to have_received(:update)
        .with(with: participant, type: :remove)
    end

    it 'tells the scoreboard to remove when number is un-set' do
      participant.update(number: nil)
      expect(ScoreboardService).to have_received(:update)
        .with(with: participant, type: :remove)
    end
  end

  describe 'completed?' do
    let(:maneuver) { create(:maneuver) }

    context 'when participant has completed maneuver' do
      before do
        create(:maneuver_participant, maneuver:, participant:)
      end

      it 'returns true' do
        expect(participant.completed?(maneuver)).to be true
      end
    end

    context 'when participant has not completed manuever' do
      it 'returns false' do
        expect(participant.completed?(maneuver)).to be false
      end
    end
  end

  describe 'total_score' do
    it 'initializes to zero' do
      expect(participant.total_score).to be 0
    end

    it 'increases by quiz score' do
      quiz_score = create(:quiz_score)
      expect { participant.update quiz_score: }
        .to change(participant, :total_score)
        .by(quiz_score.score)
    end

    it 'increases by circle check score' do
      circle_check_score = create(:circle_check_score)
      expect { participant.update circle_check_score: }
        .to change(participant, :total_score)
        .by(circle_check_score.score)
    end

    it 'increases by onboard judging score' do
      onboard_judging = create(:onboard_judging)
      expect { participant.update onboard_judging: }
        .to change(participant, :total_score)
        .by(onboard_judging.score)
    end
  end

  describe 'maneuver_score' do
    it 'returns the maneuver score' do
      maneuver_partip = create(:maneuver_participant, :perfect_score)
      expect(maneuver_partip.participant.maneuver_score).to be 50
    end
  end

  describe 'display_information' do
    subject(:call) { ->(*info) { participant.display_information(*info) } }

    let(:participant) { create(:participant) }

    it 'displays bus information' do
      expected = participant.bus.number
      expect(call[:bus]).to eql expected
    end

    it 'displays participant information' do
      expect(call[:name]).to eql participant.name
    end

    it 'displays number information' do
      expected = "##{participant.number}"
      expect(call[:number]).to eql expected
    end

    it 'displays name' do
      participant.update! name: 'Person'
      expect(call[:name]).to eql 'Person'
    end

    it 'displays and splits up multiple options' do
      exp = "#{participant.name} (#{participant.bus.number}, ##{participant.number})"
      expect(call[:name, :bus, :number]).to eql exp
    end
  end

  describe 'next_number' do
    it 'returns the last non-nil participant number' do
      create(:participant)
      last_participant = create(:participant)
      expect(described_class.next_number).to eql last_participant.number + 1
    end
  end

  describe 'scoreboard_order' do
    subject(:call) { ->(by) { described_class.scoreboard_order(by) } }

    it 'can sort participants by total score' do
      create(:onboard_judging, :perfect, participant:)
      oj2 = create(:onboard_judging, minutes_elapsed: 8)
      oj3 = create(:onboard_judging, minutes_elapsed: 9)
      expected = [participant, oj2.participant, oj3.participant]
      expect(call[:total_score]).to eql expected
    end

    it 'can sort participants by maneuver score' do
      create(:maneuver_participant, :perfect_score, participant:)
      mp2 = create(:maneuver_participant, :perfect_score, reversed_direction: 1)
      mp3 = create(:maneuver_participant, :perfect_score, reversed_direction: 2)
      expected = [participant, mp2.participant, mp3.participant]
      expect(call[:maneuver_score]).to eql expected
    end

    it 'can sort participants by participant name' do
      participant.update(name: 'Akiva')
      participant2 = create(:participant, name: 'Arta')
      participant3 = create(:participant, name: 'Molly')
      expected = [participant, participant2, participant3]
      expect(call[:participant_name]).to eq expected
    end

    it 'can sort participants by participant number' do
      participant2 = create(:participant)
      participant3 = create(:participant)
      expected = [participant, participant2, participant3]
      expect(call[:participant_number]).to eq expected
    end

    it 'raises an error if the given order is invalid' do
      expect { call[:circle_check_score] }.to raise_error ArgumentError
    end
  end
end
