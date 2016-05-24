require 'rails_helper'

describe 'deleting a bus' do
  context 'with admin privilege' do
    let!(:bus) { create :bus }
    it 'deletes a bus' do
      when_current_user_is :admin
      visit buses_url
      click_on 'Remove'
      expect(page).not_to have_text bus.number
    end
  end

  context 'with master of ceremonies privilege' do
    let!(:bus) { create :bus }
    it 'deletes a bus' do
      when_current_user_is :master_of_ceremonies
      visit buses_url
      click_on 'Remove'
      expect(page).not_to have_text bus.number
    end
  end

  context 'with judge privilege' do
    let!(:bus) { create :bus }
    it 'will not delete a bus' do
      when_current_user_is :judge
      visit buses_url
      click_on 'Remove'
      expect(page).to have_text bus.number
    end
  end
end
