# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'deleting a bus' do
  let!(:bus) { create :bus }
  context 'with admin privilege' do
    it 'deletes a bus' do
      when_current_user_is :admin
      visit buses_url
      click_on 'Remove'
      expect(page).to have_text 'Bus was successfully deleted.'
    end
  end

  context 'with master of ceremonies privilege' do
    it 'deletes a bus' do
      when_current_user_is :master_of_ceremonies
      visit buses_url
      click_on 'Remove'
      expect(page).to have_text 'Bus was successfully deleted.'
    end
  end

  context 'with judge privilege' do
    it 'will not delete a bus' do
      when_current_user_is :judge
      visit buses_url
      click_on 'Remove'
      expect(page).to have_text 'You are not authorized to make that action.'
    end
  end
end
