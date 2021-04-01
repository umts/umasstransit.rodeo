# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'finding a participant' do
  let!(:maneuver) { create :maneuver }
  let!(:record1) do
    create :maneuver_participant,
           :perfect_score, maneuver: maneuver
  end
  let!(:record2) do
    create :maneuver_participant,
           :perfect_score, maneuver: maneuver
  end
  let!(:record3) do
    create :maneuver_participant,
           :perfect_score, maneuver: maneuver
  end

  context 'finds the previous' do
    context 'when called on first participant' do
      it 'gets first participant' do
        when_current_user_is :admin
        visit maneuver_participant_path(record1.id)
        click_link 'Previous participant'
        expect = 'This is the first participant who completed this maneuver'
        expect(page).to have_text expect
      end
    end

    context 'when called on non-first participant' do
      it 'redirects to previous participant' do
        when_current_user_is :admin
        visit maneuver_participant_path(record2.id)
        click_link 'Previous participant'
        expect(page).to have_text record1.participant.name
      end
    end
  end

  context 'finds the next' do
    context 'when called on non-last participant' do
      it 'redirects to the next participant' do
        when_current_user_is :admin
        visit maneuver_participant_path(record1.id)
        click_link 'Next participant'
        expect(page).to have_text record2.participant.name
      end
    end

    context 'when called on last participant' do
      it 'displays a notice' do
        when_current_user_is :admin
        visit maneuver_participant_path(record3.id)
        click_link 'Next participant'
        expect = 'There are no more participants in the queue for this maneuver'
        expect(page).to have_text expect
      end
    end

    context 'when called on last completed participant' do
      it 'redirects to new maneuver' do
        create :participant
        when_current_user_is :admin
        visit maneuver_participant_path(record3.id)
        click_link 'Next participant'
        expect(current_path).to eql new_maneuver_participant_path
      end
    end
  end
end
