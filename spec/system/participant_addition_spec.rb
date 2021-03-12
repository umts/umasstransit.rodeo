# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'adding a participant' do
  context 'with master of ceremonies privilege' do
    it 'adds a participant' do
      when_current_user_is :master_of_ceremonies
      visit participants_path
      fill_in 'participant_name', with: 'Foo Bar'
      click_on 'Add'
      expect(page).to have_text 'Participant was successfully created.'
    end
  end
  context 'with admin privilege' do
    it 'adds a participant' do
      when_current_user_is :admin
      visit participants_path
      fill_in 'participant_name', with: 'Foo Bar'
      click_on 'Add'
      expect(page).to have_text 'Participant was successfully created.'
    end
  end
  context 'with judge privilege' do
    it 'does not add a participant' do
      when_current_user_is :judge
      visit participants_path
      fill_in 'participant_name', with: 'Foo Bar'
      click_on 'Add'
      expect(page).to have_text 'You are not authorized to make that action.'
    end
  end
  context 'that is a duplicate' do
    it 'will not add a participant' do
      when_current_user_is :admin
      create :participant, name: 'Foo Bar'
      visit participants_path
      fill_in 'Name', with: 'Foo Bar'
      click_on 'Add'
      expect(page).to have_text 'Name has already been taken'
    end
  end
  context 'with a unique number and bus number' do
    it 'will add a participant' do
      create :bus, number: 'Big Yellow Bus'
      when_current_user_is :admin
      visit participants_path
      fill_in 'participant_name', with: 'Foo Bar'
      fill_in 'participant_number', with: '1'
      select('Big Yellow Bus', from: 'participant_bus_id')
      click_on 'Add'
      expect(page).to have_text 'Participant was successfully created.'
    end
  end
  context 'with a unique number and no bus number' do
    it 'will not add a participant' do
      when_current_user_is :admin
      visit participants_path
      fill_in 'participant_name', with: 'Foo Bar'
      fill_in 'participant_number', with: '1'
      click_on 'Add'
      expect(page).to have_text "Bus can't be blank"
    end
  end
  context 'with blank fields' do
    it 'will not add a participant' do
      when_current_user_is :admin
      visit participants_path
      click_on 'Add'
      expect(page).to have_text "Name can't be blank"
    end
  end
end
