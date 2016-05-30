require 'rails_helper'

describe 'updating a participant' do
  context 'with master of ceremonies privilege' do
    it 'updates a participant' do
      create :participant, name: 'Foo Bar'
      when_current_user_is :master_of_ceremonies
      visit participants_url
      within ('tr:nth-child(3)') do
        fill_in :participant_name, with: 'Akiva Green'
      end
      click_on 'Save'
      expect(page).to have_text 'Participant has been updated.'
    end
  end
  context 'with admin privilege' do
    it 'updates a participant' do
      create :participant, name: 'Foo Bar'
      when_current_user_is :admin
      visit participants_url
      within ('tr:nth-child(3)') do
        fill_in :participant_name, with: 'Akiva Green'
      end
      click_on 'Save'
      expect(page).to have_text 'Participant has been updated.'
    end
  end
  context 'with judge privilege' do
    it 'does not update a participant' do
      create :participant, name: 'Foo Bar'
      when_current_user_is :judge
      visit participants_url
      within ('tr:nth-child(3)') do
        fill_in :participant_name, with: 'Akiva Green'
      end
      click_on 'Save'
      expect(page).to have_text 'You are not authorized to make that action.'
    end
  end
end