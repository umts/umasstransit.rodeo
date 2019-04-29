# frozen_string_literal: true

require 'rails_helper'

describe 'rake roadeo:reset' do
  before :all do
    @original_stdout = $stdout
    $stdout = File.new(File::NULL, 'w')
  end

  after :all do
    $stdout = @original_stdout
  end

  before :each do
    create :bus
    participant = create :participant
    create :circle_check_score, participant: participant
    create :quiz_score, participant: participant
    create :onboard_judging, participant: participant
    create :maneuver_participant, participant: participant
    create :user
  end

  it 'warns you and requires confirmation' do
    allow(STDIN).to receive('gets').and_return("No\n")
    expect { task.execute }.to output(/destroy all/).to_stdout
  end

  context 'when denied confirmation' do
    before :each do
      allow(STDIN).to receive('gets').and_return("No\n")
    end

    it 'does not destroy anything' do
      [Bus, Participant, CircleCheckScore, QuizScore,
       OnboardJudging, ManeuverParticipant, User].each do |model|
        expect { task.execute }.not_to change { model.count }
      end
    end
  end

  context 'when granted confirmation' do
    before :each do
      allow(STDIN).to receive('gets').and_return("YES\n")
    end

    it 'destroys all buses' do
      task.execute
      expect(Bus.count).to be 0
    end

    it 'destroys all participants' do
      task.execute
      [Participant, CircleCheckScore, QuizScore,
       OnboardJudging, ManeuverParticipant].each do |model|
        expect(model.count).to be 0
      end
    end

    it 'destroys all non-admins' do
      non_admin = create :user
      admin = create :user, :admin

      task.execute

      user_ids = User.pluck(:id)
      expect(user_ids).not_to include(non_admin.id)
      expect(user_ids).to include(admin.id)
    end
  end
end
