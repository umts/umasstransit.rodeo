require 'rails_helper'
describe 'updating wheelchair maneuver' do
  context 'with judge privilege' do
    let!(:wheelchair_maneuver) { create :wheelchair_maneuver }
    it 'updates the wheelchair maneuver' do
      when_current_user_is :judge
      visit select_participant_wheelchair_maneuvers_url
      click_link 'Review'
      check 'wheelchair_maneuver_offer_seatbelt'
      click_on 'Save'
      expect(page.find('.notice')).to have_text 'Onboard score has been saved.'
    end
  end

  context 'with admin privilege' do
    let!(:wheelchair_maneuver) do 
      create :wheelchair_maneuver,
        offer_seatbelt: false
    end
    it 'updates wheelchair maneuver' do
      when_current_user_is :admin
      visit select_participant_wheelchair_maneuvers_url
      click_link 'Review'
      check 'wheelchair_maneuver_offer_seatbelt'
      click_on 'Save'
      expect(page.find('.notice')).to have_text 'Onboard score has been saved.'
    end
  end

  context 'with circle check scorer privilege' do
    let!(:wheelchair_maneuver) do 
      create :wheelchair_maneuver,
        offer_seatbelt: false
    end
    it 'updates wheelchair maneuver' do
      when_current_user_is :circle_check_scorer
      visit select_participant_wheelchair_maneuvers_url
      click_link 'Review'
      check 'wheelchair_maneuver_offer_seatbelt'
      click_on 'Save'
      expect(page.find('.notice')).to have_text 'You are not authorized to make that action.'
    end
  end
end
