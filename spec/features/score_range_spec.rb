require 'rails_helper'

describe 'adding a score' do
  before :each do
    create :participant
  end
  context'when out of range quiz score' do
    it 'will not accept negative number' do
      when_current_user_is :admin
      visit quiz_scores_url
      fill_in 'quiz_score_points_achieved', with: '-14'
      click_on 'Save score'
      expected = 'Points achieved must be greater than or equal to 0'
      expect(page).to have_text expected
    end
  end

  context'when out of range quiz score' do
    it 'will not accept positive number greater than total points' do
      when_current_user_is :admin
      visit quiz_scores_url
      input = find_field 'quiz_score_total_points'
      out_of_range = input.value.to_i + 1
      fill_in 'quiz_score_points_achieved', with: out_of_range.to_s
      click_on 'Save score'
      expected = "Points achieved must be less than or equal to #{input.value}"
      expect(page).to have_text expected
    end
  end

  context 'when out of range circle check score' do
    it 'will not accept negative number' do
      when_current_user_is :admin
      visit circle_check_scores_url
      fill_in 'circle_check_score_defects_found', with: '-420'
      click_on 'Save score'
      expected = 'Defects found must be greater than or equal to 0'
      expect(page).to have_text expected
    end
  end

  context 'when out of range circle check score' do
    it 'will not accept positive number greater than total points' do
      when_current_user_is :admin
      visit circle_check_scores_url
      input = find_field 'circle_check_score_total_defects'
      out_of_range = input.value.to_i + 1
      fill_in 'circle_check_score_defects_found', with: out_of_range.to_s
      click_on 'Save score'
      expected = "Defects found must be less than or equal to #{input.value}"
      expect(page).to have_text expected
    end
  end
end
