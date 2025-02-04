# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'rake roadeo:reset', task: 'roadeo:reset' do
  before do
    create(:bus)
    participant = create(:participant)
    create(:circle_check_score, participant:)
    create(:quiz_score, participant:)
    create(:onboard_judging, participant:)
    create(:maneuver_participant, participant:)
    create(:user)
  end

  it 'warns you and requires confirmation' do
    allow($stdin).to receive('gets').and_return("No\n")
    expect { task.execute }.to output(/destroy all/).to_stdout
  end

  context 'when denied confirmation' do
    before do
      allow($stdin).to receive('gets').and_return("No\n")
    end

    it 'does not destroy anything' do
      [Bus, Participant, CircleCheckScore, QuizScore,
       OnboardJudging, ManeuverParticipant, User, PaperTrail::Version].each do |model|
        expect { task.execute }.not_to change(model, :count)
      end
    end

    it 'does not change whether scores are locked' do
      expect { task.execute }.not_to(change { Settings.instance.scores_locked })
    end
  end

  context 'when granted confirmation' do
    before do
      allow($stdin).to receive('gets').and_return("YES\n")
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
      non_admin = create(:user)
      task.execute
      expect(User.pluck(:id)).not_to include(non_admin.id)
    end

    it 'does not destroy admins' do
      admin = create(:user, :admin)
      task.execute
      expect(User.pluck(:id)).to include(admin.id)
    end

    it 'locks scores from being updated' do
      task.execute
      expect(Settings.instance.scores_locked).to be true
    end

    context 'when an argument is passed' do
      it 'destroys all paper trail records other than users' do
        expect { task.invoke('true') }.to change { PaperTrail::Version.where.not(item_type: 'User').count }.to 0
      end
    end

    context 'when no argument is passed' do
      it 'retains all paper trail records' do
        previous_records = PaperTrail::Version.all.to_a
        task.execute
        expect(PaperTrail::Version.all.to_a).to include(*previous_records)
      end
    end
  end
end
