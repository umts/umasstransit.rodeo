require 'rails_helper'

describe 'updating a quiz score' do
  before :each do
    create :quiz_score, points_achieved: 50, total_points: 100
  end

  context 'with admin privilege' do
    it 'updates quiz score' do
      when_current_user_is :admin
      visit quiz_scores_url
      fill_in 'quiz_score_points_achieved', with: '70'
      click_on 'Save score'
      expect(page).to have_text 'Quiz score was saved.'
      input = find_field :quiz_score_points_achieved
      expect(input.value).to eql '70.0'
    end
  end

  context 'with quiz_scorer privilege' do
    it 'updates quiz score' do
      when_current_user_is :quiz_scorer
      visit quiz_scores_url
      fill_in 'quiz_score_points_achieved', with: '70'
      click_on 'Save score'
      expect(page).to have_text 'Quiz score was saved.'
      input = find_field :quiz_score_points_achieved
      expect(input.value).to eql '70.0'
    end
  end
  context 'with judge privilege' do
    it 'will not update quiz score' do
      when_current_user_is :judge
      visit quiz_scores_url
      fill_in 'quiz_score_points_achieved', with: '70'
      click_on 'Save score'
      expect(page).not_to have_text 'Quiz score was saved.'
    end
  end
end
