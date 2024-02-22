# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'deleting a bus' do
  let!(:bus) { create(:bus) }

  context 'with admin privilege' do
    before do
      when_current_user_is :admin
      visit buses_path
    end

    it 'deletes a bus' do
      click_on 'Remove'
      expect(Bus.exists?(bus.id)).to be false
    end

    it 'informs you of the deletion' do
      click_on 'Remove'
      expect(page).to have_text 'Bus was successfully deleted.'
    end
  end

  context 'with master of ceremonies privilege' do
    before do
      when_current_user_is :master_of_ceremonies
      visit buses_path
    end

    it 'deletes a bus' do
      click_on 'Remove'
      expect(Bus.exists?(bus.id)).to be false
    end

    it 'informs you of the deletion' do
      click_on 'Remove'
      expect(page).to have_text 'Bus was successfully deleted.'
    end
  end

  context 'with judge privilege' do
    before do
      when_current_user_is :judge
      visit buses_path
    end

    it 'does not delete the bus' do
      click_on 'Remove'
      expect(Bus.exists?(bus.id)).to be true
    end

    it 'informs you of the failure' do
      click_on 'Remove'
      expect(page).to have_text 'You are not authorized to make that action.'
    end
  end
end
