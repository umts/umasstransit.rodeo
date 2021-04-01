# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'updating a participant' do
  context 'with master of ceremonies privilege' do
    it 'updates a participant' do
      participant = create :participant, name: 'Foo Bar'
      when_current_user_is :master_of_ceremonies
      visit participants_path
      form = find "form#edit_participant_#{participant.id}"
      within form do
        fill_in :participant_name, with: 'Akiva Green'
        click_on 'Save'
      end
      expect(page).to have_text 'Participant has been updated.'
    end

    it 'will assign a number' do
      create :bus, number: 'Big Yellow Bus'
      when_current_user_is :master_of_ceremonies
      visit participants_path
      fill_in 'participant_name', with: 'Foo Bar'
      click_on 'Add'
      select 'Foo Bar', from: 'id'
      select 'Big Yellow Bus', from: 'bus_id'
      click_on 'Add to maneuver queue'
      expect(page).to have_text 'Participant has been added to the queue.'
    end
  end

  context 'will not assign a duplicate number' do
    it 'does not update a participant' do
      create :participant, number: 1
      create :participant, number: 2
      when_current_user_is :admin
      visit participants_path
      fill_in 'participant_number', with: 2, match: :first
      click_on 'Save', match: :first
      expect(page).to have_text 'Please choose a unique participant number.'
    end
  end

  context 'with admin privilege' do
    it 'updates a participant' do
      participant = create :participant, name: 'Foo Bar'
      when_current_user_is :admin
      visit participants_path
      form = find "form#edit_participant_#{participant.id}"
      within form do
        fill_in :participant_name, with: 'Akiva Green'
        click_on 'Save'
      end
      expect(page).to have_text 'Participant has been updated.'
    end
  end

  context 'with judge privilege' do
    it 'does not update a participant' do
      participant = create :participant, name: 'Foo Bar'
      when_current_user_is :judge
      visit participants_path
      form = find "form#edit_participant_#{participant.id}"
      within form do
        fill_in :participant_name, with: 'Akiva Green'
        click_on 'Save'
      end
      expect(page).to have_text 'You are not authorized to make that action.'
    end
  end
end
