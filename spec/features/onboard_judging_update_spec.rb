require 'rails_helper'
describe 'updating onboard judging' do
  context 'with judge privilege' do
    let!(:onboard_judging) { create :onboard_judging, :perfect }
    it 'updates onboard judging' do
      when_current_user_is :judge
      visit select_participant_onboard_judgings_url
      click_link 'Review'
      fill_in 'onboard_judging_minutes_elapsed', with: '10'
      click_on 'Save'
      expect(page).to have_text 'Onboard score has been saved.'
    end
  end

  context 'with admin privilege' do
    let!(:onboard_judging) { create :onboard_judging, :perfect }
    it 'updates onboard judging' do
      when_current_user_is :admin
      visit select_participant_onboard_judgings_url
      click_link 'Review'
      fill_in 'onboard_judging_minutes_elapsed', with: '10'
      click_on 'Save'
      expect(page).to have_text 'Onboard score has been saved.'
    end
  end

  context 'with circle check scorer privilege' do
    let!(:onboard_judging) { create :onboard_judging, :perfect }
    it 'updates onboard judging' do
      when_current_user_is :circle_check_scorer
      visit select_participant_onboard_judgings_url
      click_link 'Review'
      fill_in 'onboard_judging_minutes_elapsed', with: '10'
      click_on 'Save'
      expect(page).to have_text 'You are not authorized to make that action.'
    end
  end
end
