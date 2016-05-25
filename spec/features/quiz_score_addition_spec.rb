require 'rails_helper'

describe 'adding a quiz score' do
  before :each do
    create :participant
  end

  context 'with judge privilege' do
    it 'will not add the quiz score' do
      when_current_user_is :judge
      visit quiz_scores_url
      fill_in 'quiz_score_points_achieved', with: '70'
      click_on 'Save score'
      expect(page).not_to have_text 'Quiz score was saved.'
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
end
