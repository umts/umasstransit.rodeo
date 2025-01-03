# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'finding a participant' do
  let!(:maneuver) { create(:maneuver) }
  let!(:records) { create_list(:maneuver_participant, 3, :perfect_score, maneuver:) }

  describe 'previous participant' do
    context 'when called on first participant' do
      it 'gets first participant' do
        when_current_user_is :admin
        visit maneuver_participant_path(records.first)
        click_link 'Previous participant'
        expect = 'This is the first participant who completed this maneuver'
        expect(page).to have_text expect
      end
    end

    context 'when called on non-first participant' do
      it 'redirects to previous participant' do
        when_current_user_is :admin
        visit maneuver_participant_path(records.second)
        click_link 'Previous participant'
        expect(page).to have_text records.first.participant.name
      end
    end
  end

  describe 'next participant' do
    context 'when called on non-last participant' do
      it 'redirects to the next participant' do
        when_current_user_is :admin
        visit maneuver_participant_path(records.first)
        click_link 'Next participant'
        expect(page).to have_text records.second.participant.name
      end
    end

    context 'when called on last participant' do
      it 'displays a notice' do
        when_current_user_is :admin
        visit maneuver_participant_path(records.last)
        click_link 'Next participant'
        expect = 'There are no more participants in the queue for this maneuver'
        expect(page).to have_text expect
      end
    end

    context 'when called on last completed participant' do
      it 'redirects to new maneuver' do
        create(:participant)
        when_current_user_is :admin
        visit maneuver_participant_path(records.last)
        click_link 'Next participant'
        expect(page).to have_current_path(new_maneuver_participant_path, ignore_query: true)
      end
    end
  end
end
