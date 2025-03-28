# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'removing a participant' do
  before do
    create(:participant)
  end

  context 'with admin privilege' do
    it 'removes a participant' do
      when_current_user_is :admin
      visit participants_path
      click_on 'Remove'
      expect(page).to have_text 'Participant has been removed'
    end
  end

  context 'with master of ceremonies privilege' do
    it 'removes a participant' do
      when_current_user_is :master_of_ceremonies
      visit participants_path
      click_on 'Remove'
      expect(page).to have_text 'Participant has been removed'
    end
  end

  context 'with judge privilege' do
    it 'does not remove a participant' do
      when_current_user_is :judge
      visit participants_path
      click_on 'Remove'
      expect(page).to have_text 'You are not authorized to take that action'
    end
  end
end
