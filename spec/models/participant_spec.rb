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
      expect(participant.maneuver_score).to eql 0
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
        exp = participant.name.to_s + ' (' + participant.bus.number +
              ', #' + participant.number.to_s + ')'
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

describe 'scoreboard_order' do
  context 'total score' do
    it 'sorts score' do
      per = create :onboard_judging, :perfect
      per_2 = create :onboard_judging, minutes_elapsed: 8
      per_3 = create :onboard_judging, minutes_elapsed: 9
      p_1 = per.participant
      p_2 = per_2.participant
      p_3 = per_3.participant
      expected = [p_1, p_2, p_3]
      expect(Participant.scoreboard_order(:total_score)).to eql expected
    end
  end
end
