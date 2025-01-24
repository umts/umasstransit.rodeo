# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'updating a participant' do
  let(:participant_row) do
    ->(participant) { %(tr[data-participant-id="#{participant.id}"]) }
  end

  context 'with master of ceremonies privilege' do
    let!(:participant) { create(:participant, name: 'Foo Bar') }

    before do
      create(:bus, number: 'Big Yellow Bus')
      when_current_user_is :master_of_ceremonies
      visit participants_path
    end

    it 'updates a participant' do
      within participant_row[participant] do
        fill_in 'participant[name]', with: 'Akiva Green'
        click_on 'Save'
      end
      expect(page).to have_text 'Participant has been updated'
    end

    context 'with a numberless participant' do
      before do
        within 'tr#new_participant' do
          fill_in 'participant_name', with: 'Teddy Bear'
          click_on 'Add'
        end
        within 'form#add_to_queue' do
          select 'Teddy Bear', from: 'id'
          select 'Big Yellow Bus', from: 'bus_id'
        end
      end

      it 'assigns a number' do
        within 'form#add_to_queue' do
          click_on 'Add to maneuver queue'
        end
        expect(page).to have_text 'Participant has been added to the queue'
      end
    end
  end

  context 'with another participant' do
    before do
      create(:participant, number: 1)
      create(:participant, number: 2)
      when_current_user_is :admin
      visit participants_path
    end

    it 'does not allow duplicate numbers' do
      fill_in 'participant_number', with: 2, match: :first
      click_on 'Save', match: :first
      expect(page).to have_text 'Please choose a unique participant number'
    end
  end

  context 'with admin privilege' do
    let!(:participant) { create(:participant, name: 'Harf Buzz') }

    before do
      when_current_user_is :admin
      visit participants_path
    end

    it 'updates a participant' do
      within participant_row[participant] do
        fill_in 'participant[name]', with: 'Akiva Green'
        click_on 'Save'
      end
      expect(page).to have_text 'Participant has been updated'
    end
  end

  context 'with judge privilege' do
    let!(:participant) { create(:participant, name: 'Sniff Snagg') }

    before do
      when_current_user_is :judge
      visit participants_path
    end

    it 'does not update a participant' do
      within participant_row[participant] do
        fill_in 'participant[name]', with: 'Akiva Green'
        click_on 'Save'
      end
      expect(page).to have_text 'You are not authorized to take that action'
    end
  end
end
