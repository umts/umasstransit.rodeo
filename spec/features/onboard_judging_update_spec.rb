require 'rails_helper'
describe 'updating onboard judging' do
  context 'with judge priviledge' do
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
end
