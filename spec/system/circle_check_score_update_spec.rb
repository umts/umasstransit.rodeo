# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'updating a circle check score' do
  before do
    create(:circle_check_score, total_defects: 5, defects_found: 3)
  end

  context 'with admin privilege' do
    before do
      when_current_user_is :admin
      visit circle_check_scores_path
    end

    it 'updates circle check score' do
      fill_in 'circle_check_score_defects_found', with: '4'
      click_on 'Save score'
      input = find_field :circle_check_score_defects_found
      expect(input.value).to eql '4'
    end

    it 'informs you of success' do
      fill_in 'circle_check_score_defects_found', with: '4'
      click_on 'Save score'
      expect(page).to have_text 'Circle check score was saved.'
    end
  end

  context 'with circle check scorer privilege' do
    before do
      when_current_user_is :circle_check_scorer
      visit circle_check_scores_path
    end

    it 'updates circle check score' do
      fill_in 'circle_check_score_defects_found', with: '4'
      click_on 'Save score'
      input = find_field :circle_check_score_defects_found
      expect(input.value).to eql '4'
    end

    it 'informs you of success' do
      fill_in 'circle_check_score_defects_found', with: '4'
      click_on 'Save score'
      expect(page).to have_text 'Circle check score was saved.'
    end
  end

  context 'with judge privilege' do
    before do
      when_current_user_is :judge
      visit circle_check_scores_path
    end

    it 'does not update circle check score' do
      fill_in 'circle_check_score_defects_found', with: '4'
      click_on 'Save score'
      expect(page).to have_no_text 'Circle check score was saved.'
    end
  end

  context 'with a negative score' do
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

  context 'with a blank score' do
    before do
      when_current_user_is :admin
      visit circle_check_scores_path
      fill_in 'circle_check_score_defects_found', with: ''
    end

    it 'does not accept a blank field' do
      click_on 'Save score'
      expected = "Defects found can't be blank"
      expect(page).to have_text expected
    end
  end

  context 'with an out of range score' do
    let!(:total_defects) do
      when_current_user_is :admin
      visit circle_check_scores_path
      input = find_field 'circle_check_score_total_defects'
      input.value.to_i
    end

    it 'does not accept positive number greater than total points' do
      fill_in 'circle_check_score_defects_found', with: (total_defects + 1).to_s
      click_on 'Save score'
      expected = "Defects found must be less than or equal to #{total_defects}"
      expect(page).to have_text expected
    end
  end
end
