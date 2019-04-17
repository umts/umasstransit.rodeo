# frozen_string_literal: true

require 'rails_helper'

describe 'adding a quiz score' do
  let!(:participant) { create :participant }
  it'shows user name' do
    when_current_user_is :admin
    visit quiz_scores_url
    fill_in 'quiz_score_points_achieved', with: '2'
    click_on 'Save score'
    expect(page).to have_text participant.name.to_s
  end
  context 'with judge privilege' do
    it 'will not add the quiz score' do
      when_current_user_is :judge
      visit quiz_scores_url
      fill_in 'quiz_score_points_achieved', with: '70'
      click_on 'Save score'
      expect(page).to have_text 'You are not authorized to make that action.'
    end
  end
  context 'with quiz scorer privilege' do
    it 'adds the quiz score' do
      when_current_user_is :quiz_scorer
      visit quiz_scores_url
      fill_in 'quiz_score_points_achieved', with: '50'
      click_on 'Save score'
      expect(page).to have_text 'Quiz score was saved.'
      input = find_field :quiz_score_points_achieved
      expect(input.value).to eql '50.0'
    end
  end
  context 'with admin privilege' do
    it 'adds the quiz score' do
      when_current_user_is :admin
      visit quiz_scores_url
      fill_in 'quiz_score_points_achieved', with: '50'
      click_on 'Save score'
      expect(page).to have_text 'Quiz score was saved.'
      input = find_field :quiz_score_points_achieved
      expect(input.value).to eql '50.0'
    end
  end
  context 'with blank fields' do
    it 'will not add a quiz score' do
      when_current_user_is :admin
      visit quiz_scores_url
      click_on 'Save score'
      expect(page).to have_text "Points achieved can't be blank"
    end
  end
  context 'when out of range' do
    it 'will not accept negative number' do
      when_current_user_is :admin
      visit quiz_scores_url
      fill_in 'quiz_score_points_achieved', with: '-14'
      click_on 'Save score'
      expected = 'Points achieved must be greater than or equal to 0'
      expect(page).to have_text expected
    end
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
end
