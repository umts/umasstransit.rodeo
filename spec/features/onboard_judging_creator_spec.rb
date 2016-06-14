require 'rails_helper'
describe 'recording an onboard judging score' do
  context 'with judge privilege' do
    let(:judge) { create :user, :judge }
    let(:participant) { create :participant }
    it 'records the creator' do
      when_current_user_is judge
      visit new_onboard_judging_path(participant: participant.number)
      expect { click_on 'Save' }
        .to change { OnboardJudging.count }
        .by 1
      expect(OnboardJudging.last.creator).to eql judge
    end
  end
  context 'with admin privilege' do
    let(:admin) { create :user, :admin }
    let(:participant) { create :participant }
    it 'records the creator' do
      when_current_user_is admin
      visit new_onboard_judging_path(participant: participant.number)
      expect { click_on 'Save' }
        .to change { OnboardJudging.count }
        .by 1
      expect(OnboardJudging.last.creator).to eql admin
    end
  end
  context 'with quiz scorer privilege' do
    let(:quiz_scorer) { create :user, :quiz_scorer }
    let(:participant) { create :participant }
    it 'records the creator' do
      when_current_user_is quiz_scorer
      visit new_onboard_judging_path(participant: participant.number)
      expect { click_on 'Save' }
        .not_to change { OnboardJudging.count }
      expect(page).to have_text 'You are not authorized to make that action.'
    end
  end
end
