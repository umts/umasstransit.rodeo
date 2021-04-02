# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'updating onboard judging' do
  let!(:onboard_judging) { create :onboard_judging, :perfect }

  context 'with judge privilege' do
    before do
      when_current_user_is :judge
      visit select_participant_onboard_judgings_path
      click_link 'Review'
    end

    it 'updates onboard judging' do
      fill_in 'onboard_judging_minutes_elapsed', with: '10'
      click_on 'Save'
      expect(onboard_judging.reload.minutes_elapsed).to be(10)
    end

    it 'Informs you of success' do
      fill_in 'onboard_judging_minutes_elapsed', with: '10'
      click_on 'Save'
      expect(page).to have_text 'Onboard score has been saved.'
    end
  end

  context 'with admin privilege' do
    before do
      when_current_user_is :admin
      visit select_participant_onboard_judgings_path
      click_link 'Review'
    end

    it 'updates onboard judging' do
      fill_in 'onboard_judging_minutes_elapsed', with: '10'
      click_on 'Save'
      expect(onboard_judging.reload.minutes_elapsed).to be(10)
    end

    it 'Informs you of success' do
      fill_in 'onboard_judging_minutes_elapsed', with: '10'
      click_on 'Save'
      expect(page).to have_text 'Onboard score has been saved.'
    end
  end

  context 'with circle check scorer privilege' do
    before do
      when_current_user_is :circle_check_scorer
      visit select_participant_onboard_judgings_path
      click_link 'Review'
    end

    it 'informs you of failure' do
      fill_in 'onboard_judging_minutes_elapsed', with: '10'
      click_on 'Save'
      expect(page).to have_text 'You are not authorized to make that action.'
    end
  end
end
