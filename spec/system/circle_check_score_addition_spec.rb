# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'adding a circle check score' do
  before do
    create(:participant)
  end

  context 'with admin privilege' do
    before do
      when_current_user_is :admin
      visit circle_check_scores_path
    end

    it 'adds circle check score' do
      fill_in 'circle_check_score_defects_found', with: '4'
      click_on 'Save score'
      input = find_field :circle_check_score_defects_found
      expect(input.value).to eql '4'
    end

    it 'informs you of success' do
      fill_in 'circle_check_score_defects_found', with: '4'
      click_on 'Save score'
      expect(page).to have_text 'Circle check score has been saved'
    end
  end

  context 'with circle check scorer privilege' do
    before do
      when_current_user_is :circle_check_scorer
      visit circle_check_scores_path
    end

    it 'adds circle check score' do
      fill_in 'circle_check_score_defects_found', with: '4'
      click_on 'Save score'
      input = find_field :circle_check_score_defects_found
      expect(input.value).to eql '4'
    end

    it 'informs you of success' do
      fill_in 'circle_check_score_defects_found', with: '4'
      click_on 'Save score'
      expect(page).to have_text 'Circle check score has been saved'
    end
  end

  context 'with judge privilege' do
    before do
      when_current_user_is :judge
      visit circle_check_scores_path
    end

    it 'does not add a circle check score' do
      fill_in 'circle_check_score_defects_found', with: '4'
      click_on 'Save score'
      expect(page).to have_text 'You are not authorized to take that action'
    end
  end

  context 'with blank fields' do
    it 'does not add a circle check score' do
      when_current_user_is :admin
      visit circle_check_scores_path
      click_on 'Save score'
      expect(page).to have_text "Defects found can't be blank"
    end
  end

  context 'when defects found is negative' do
    before do
      when_current_user_is :admin
      visit circle_check_scores_path
      fill_in 'circle_check_score_defects_found', with: '-420'
    end

    it 'does not accept negative number' do
      click_on 'Save score'
      expected = 'Defects found must be greater than or equal to 0'
      expect(page).to have_text expected
    end
  end

  context 'when defects found is more than the total' do
    before do
      when_current_user_is :admin
      visit circle_check_scores_path
      fill_in 'circle_check_score_defects_found', with: 5
      fill_in 'circle_check_score_total_defects', with: 4
    end

    it 'does not accept positive number greater than total points' do
      click_on 'Save score'
      expected = 'Defects found must be less than or equal to 4'
      expect(page).to have_text expected
    end
  end
end
