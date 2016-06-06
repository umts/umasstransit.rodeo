require 'rails_helper'

describe Participant do
  let!(:participant) { create :participant }
  describe 'has_completed?' do
    let!(:maneuver) { create :maneuver }
    let!(:maneuver_participant) { create :maneuver_participant }
    context 'participant has completed maneuver' do
      before :each do
        create :maneuver_participant, maneuver: maneuver,
                                      participant: participant
      end
      it 'returns true' do
        expect(participant.has_completed?(maneuver)).to be true
      end
    end
    context 'participant has not completed manuever' do
      it 'returns false' do
        expect(participant.has_completed?(maneuver)).to be false
      end
    end
  end
  describe 'total_score' do
    it 'initializes to zero' do
      expect(participant.total_score).to eql 0
    end
    it 'increases by quiz score' do
      quiz_score = create :quiz_score
      expect { participant.update quiz_score: quiz_score }
        .to change { participant.total_score }
        .by(quiz_score.score)
    end
    it 'increases by circle check score' do
      circle_check_score = create :circle_check_score
      expect { participant.update circle_check_score: circle_check_score }
        .to change { participant.total_score }
        .by(circle_check_score.score)
    end
    it 'increases by onboard judging score' do
      onboard_judging = create :onboard_judging
      expect { participant.update onboard_judging: onboard_judging }
        .to change { participant.total_score }
        .by(onboard_judging.score)
    end
  end
  describe 'maneuver_score' do
    it 'returns the maneuver score' do
      maneuver_partip = create :maneuver_participant, :perfect_score
      expect(maneuver_partip.participant.maneuver_score).to eql 50
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
        expected = '#' + participant.number.to_s
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
        exp =  name + ' (' + bus_number + ', #' + number + ')'
        expect(participant.display_information(:name, :bus, :number)).to eql exp
      end
    end
  end
  describe 'next_number' do
    it 'returns the last non-nil participant number' do
      create :participant
      p_2 = create :participant
      expect(Participant.next_number).to eql p_2.number + 1
    end
  end
end
describe 'scoreboard order' do
  context 'total score' do
    it 'sorts participants by total score' do
      onboard_judge_1 = create :onboard_judging, :perfect
      onboard_judge_2 = create :onboard_judging, minutes_elapsed: 8
      onboard_judge_3 = create :onboard_judging, minutes_elapsed: 9
      participant_1 = onboard_judge_1.participant
      participant_2 = onboard_judge_2.participant
      participant_3 = onboard_judge_3.participant
      expected = [participant_1, participant_2, participant_3]
      expect(Participant.scoreboard_order(:total_score)).to eql expected
    end
  end
  context 'maneuver score' do
    it 'sorts participants by maneuver score' do
      maneuver_partip_1 = create :maneuver_participant, :perfect_score
      maneuver_partip_2 = create :maneuver_participant,
                                 :perfect_score, reversed_direction: 1
      maneuver_partip_3 = create :maneuver_participant,
                                 :perfect_score, reversed_direction: 2
      participant_1 = maneuver_partip_1.participant
      participant_2 = maneuver_partip_2.participant
      participant_3 = maneuver_partip_3.participant
      expected = [participant_1, participant_2, participant_3]
      expect(Participant.scoreboard_order(:maneuver_score)).to eql expected
    end
  end
  context 'participant_name' do
    it 'sorts participants by participant name' do
      participant_1 = create :participant, name: 'Akiva'
      participant_2 = create :participant, name: 'Arta'
      participant_3 = create :participant, name: 'Molly'
      expected = [participant_1, participant_2, participant_3]
      expect(Participant.scoreboard_order(:participant_name)).to eq expected
    end
  end
  context 'participant_number' do
    it 'sorts participants by participant number' do
      participant_1 = create :participant
      participant_2 = create :participant
      participant_3 = create :participant
      expected = [participant_1, participant_2, participant_3]
      expect(Participant.scoreboard_order(:participant_number)).to eq expected
    end
  end
end

describe 'top_20' do
  context'doesnt include anyone after 20th person' do
    it 'holds 20 people' do
      21.times { create :participant }
      partip_array = Participant.top_20
      expect !partip_array.include?(Participant.last)
    end
  end
end
