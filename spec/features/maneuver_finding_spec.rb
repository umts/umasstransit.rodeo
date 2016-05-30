require 'rails_helper'

describe 'finding a participant' do
  let!(:maneuver) { create :maneuver }
  let!(:record_1) do
    create :maneuver_participant,
           :perfect_score, maneuver: maneuver
  end
  let!(:record_2) do
    create :maneuver_participant,
           :perfect_score, maneuver: maneuver
  end
  let!(:record_3) do
    create :maneuver_participant,
           :perfect_score, maneuver: maneuver
  end
  context 'finds the previous' do
    it 'at first participant gets first participant' do
      when_current_user_is :admin
      visit maneuver_participant_path(record_1.id)
      click_link 'Previous participant'
      expects = 'This is the first participant who completed this maneuver.'
      expect(page).to have_text expects
    end
    it 'at non-first participant redirects to previous' do
      when_current_user_is :admin
      visit maneuver_participant_path(record_2.id)
      click_link 'Previous participant'
      expect(page).to have_text record_1.participant.name
    end
  end
  context 'finds the next' do
    it 'at non-last participant gets next' do
      when_current_user_is :admin
      visit maneuver_participant_path(record_1.id)
      click_link 'Next participant'
      expect(page).to have_text record_2.participant.name
    end
    it 'at last participant redirects to notice' do
      when_current_user_is :admin
      visit maneuver_participant_path(record_3.id)
      click_link 'Next participant'
      expects = 'There are no more participants in the queue for this maneuver.'
      expect(page).to have_text expects
    end
    it 'at last completed participant redirects to new maneuver' do
      create :participant
      when_current_user_is :admin
      visit maneuver_participant_path(record_3.id)
      click_link 'Next participant'
      expect(current_path).to eql new_maneuver_participant_path
    end
  end
end
