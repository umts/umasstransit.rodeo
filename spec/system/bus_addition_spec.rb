# frozen_string_literal: true

require 'rails_helper'

describe 'adding a bus' do
  context 'with admin privilege' do
    it 'adds the bus' do
      when_current_user_is :admin
      visit buses_url
      fill_in 'bus_number', with: 'Big Yellow Bus'
      click_on 'Add'
      expect(page).to have_text 'Bus was successfully added.'
    end
  end
  context 'with master of ceremonies privilege' do
    it 'adds the bus' do
      when_current_user_is :master_of_ceremonies
      visit buses_url
      fill_in 'bus_number', with: 'Big Yellow Bus'
      click_on 'Add'
      expect(page).to have_text 'Bus was successfully added.'
    end
  end
  context 'with judge privilege' do
    it 'will not add a bus' do
      when_current_user_is :judge
      visit buses_url
      fill_in 'bus_number', with: 'Big Yellow Bus'
      click_on 'Add'
      expect(page).to have_text 'You are not authorized to make that action.'
    end
  end
  context 'with a number not filled in' do
    it 'explains that number is needed' do
      when_current_user_is :admin
      visit buses_url
      click_on 'Add'
      expect(page).to have_text "Number can't be blank"
    end
  end
end
