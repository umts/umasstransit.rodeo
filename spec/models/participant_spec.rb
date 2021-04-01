# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Participant do
  let!(:participant) { create :participant }

  describe 'update_scoreboard' do
    it 'tells the scoreboard to add on create with number' do
      expect(ScoreboardService).to receive(:update)
        .with(with: instance_of(described_class), type: :add)
      create :participant
    end

    it 'does not tell the scoreboard to add on create without number' do
      expect(ScoreboardService).not_to receive(:update)
      create :participant, number: nil
    end

    it 'tells the scoreboard to add when number is set' do
      new_participant = create :participant, number: nil
      expect(ScoreboardService).to receive(:update)
        .with(with: new_participant, type: :add)
      new_participant.update(number: 999)
    end

    it 'tells the scoreboard to update on update' do
      expect(ScoreboardService).to receive(:update)
        .with(with: participant)
      participant.update(name: 'Padington Bear')
    end

    it 'tells the scoreboard to remove on destroy' do
      expect(ScoreboardService).to receive(:update)
        .with(with: participant, type: :remove)
      participant.destroy
    end

    it 'tells the scoreboard to remove when number is un-set' do
      expect(ScoreboardService).to receive(:update)
        .with(with: participant, type: :remove)
      participant.update(number: nil)
    end
  end

  describe 'completed?' do
    let!(:maneuver) { create :maneuver }
    let!(:maneuver_participant) { create :maneuver_participant }

    context 'participant has completed maneuver' do
      before do
        create :maneuver_participant, maneuver: maneuver,
                                      participant: participant
      end

      it 'returns true' do
        expect(participant.completed?(maneuver)).to be true
      end
    end

    context 'participant has not completed manuever' do
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
      quiz_score = create :quiz_score
      expect { participant.update quiz_score: quiz_score }
        .to change(participant, :total_score)
        .by(quiz_score.score)
    end

    it 'increases by circle check score' do
      circle_check_score = create :circle_check_score
      expect { participant.update circle_check_score: circle_check_score }
        .to change(participant, :total_score)
        .by(circle_check_score.score)
    end

    it 'increases by onboard judging score' do
      onboard_judging = create :onboard_judging
      expect { participant.update onboard_judging: onboard_judging }
        .to change(participant, :total_score)
        .by(onboard_judging.score)
    end
  end

  describe 'maneuver_score' do
    it 'returns the maneuver score' do
      maneuver_partip = create :maneuver_participant, :perfect_score
      expect(maneuver_partip.participant.maneuver_score).to be 50
    end
  end

  describe 'display_information' do
    let!(:participant) { create :participant }

    context 'displays bus information' do
      it 'returns valid string' do
        expected = participant.bus.number
        expect(participant.display_information(:bus)).to eql expected
      end
    end

    context 'displays participant information' do
      it 'returns valid string' do
        expect(participant.display_information(:name)).to eql participant.name
      end
    end

    context 'displays number information' do
      it 'returns valid string' do
        expected = "##{participant.number}"
        expect(participant.display_information(:number)).to eql expected
      end
    end

    context 'displays name' do
      it 'shows name' do
        participant.update! name: 'Person'
        expect(participant.display_information(:name)).to eql 'Person'
      end
    end

    context 'displays three options' do
      it 'splits up options' do
        name = participant.name
        bus_number = participant.bus.number
        number = participant.number.to_s
        exp =  "#{name} (#{bus_number}, ##{number})"
        expect(participant.display_information(:name, :bus, :number)).to eql exp
      end
    end
  end

  describe 'next_number' do
    it 'returns the last non-nil participant number' do
      create :participant
      last_participant = create :participant
      expect(described_class.next_number).to eql last_participant.number + 1
    end
  end
end

RSpec.describe 'scoreboard order' do
  context 'total score' do
    it 'sorts participants by total score' do
      onboard_judge1 = create :onboard_judging, :perfect
      onboard_judge2 = create :onboard_judging, minutes_elapsed: 8
      onboard_judge3 = create :onboard_judging, minutes_elapsed: 9
      participant1 = onboard_judge1.participant
      participant2 = onboard_judge2.participant
      participant3 = onboard_judge3.participant
      expected = [participant1, participant2, participant3]
      expect(Participant.scoreboard_order(:total_score)).to eql expected
    end
  end

  context 'maneuver score' do
    it 'sorts participants by maneuver score' do
      maneuver_partip1 = create :maneuver_participant, :perfect_score
      maneuver_partip2 = create :maneuver_participant,
                                :perfect_score, reversed_direction: 1
      maneuver_partip3 = create :maneuver_participant,
                                :perfect_score, reversed_direction: 2
      participant1 = maneuver_partip1.participant
      participant2 = maneuver_partip2.participant
      participant3 = maneuver_partip3.participant
      expected = [participant1, participant2, participant3]
      expect(Participant.scoreboard_order(:maneuver_score)).to eql expected
    end
  end

  context 'participant_name' do
    it 'sorts participants by participant name' do
      participant1 = create :participant, name: 'Akiva'
      participant2 = create :participant, name: 'Arta'
      participant3 = create :participant, name: 'Molly'
      expected = [participant1, participant2, participant3]
      expect(Participant.scoreboard_order(:participant_name)).to eq expected
    end
  end

  context 'participant_number' do
    it 'sorts participants by participant number' do
      participant1 = create :participant
      participant2 = create :participant
      participant3 = create :participant
      expected = [participant1, participant2, participant3]
      expect(Participant.scoreboard_order(:participant_number)).to eq expected
    end
  end
end

RSpec.describe 'name_shown' do
  context 'excluding anyone not in top 20' do
    it 'excludes participant with 21st highest score' do
      create_list :maneuver_participant, 20, :perfect_score
      imperfect_score = create :maneuver_participant, :perfect_score,
                               reversed_direction: 2
      expect(Participant.name_shown).not_to include imperfect_score.participant
    end
  end

  context 'including anyone in top 20' do
    it 'includes participant with highest score' do
      top_score = create :maneuver_participant, :perfect_score
      create_list :maneuver_participant, 19, :perfect_score
      expect(Participant.name_shown).to include top_score.participant
    end
  end
end
