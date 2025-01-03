# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'adding a quiz score' do
  let(:role) { :admin }
  let!(:participant) { create(:participant) }

  before do
    when_current_user_is role
    visit quiz_scores_path
  end

  it 'shows user name' do
    fill_in 'quiz_score_points_achieved', with: '2'
    click_on 'Save score'
    expect(page).to have_text participant.name.to_s
  end

  context 'with judge privilege' do
    let(:role) { :judge }

    it 'does not add the quiz score' do
      fill_in 'quiz_score_points_achieved', with: '70'
      click_on 'Save score'
      expect(participant.quiz_score).to be_blank
    end

    it 'informs you of failure' do
      fill_in 'quiz_score_points_achieved', with: '70'
      click_on 'Save score'
      expect(page).to have_text 'You are not authorized to take that action'
    end
  end

  context 'with quiz scorer privilege' do
    let(:field) { 'quiz_score_points_achieved' }
    let(:role) { :quiz_scorer }

    it 'adds the quiz score' do
      fill_in field, with: '50'
      click_on 'Save score'
      expect(page).to have_field(field, with: '50.0')
    end

    it 'informs you of success' do
      fill_in field, with: '50'
      click_on 'Save score'
      expect(page).to have_text 'Quiz score has been saved'
    end
  end

  context 'with admin privilege' do
    let(:field) { 'quiz_score_points_achieved' }

    it 'adds the quiz score' do
      fill_in field, with: '50'
      click_on 'Save score'
      expect(page).to have_field(field, with: '50.0')
    end

    it 'informs you of success' do
      fill_in field, with: '50'
      click_on 'Save score'
      expect(page).to have_text 'Quiz score has been saved'
    end
  end

  context 'with blank fields' do
    it 'does not add a quiz score' do
      click_on 'Save score'
      expect(participant.quiz_score).to be_blank
    end

    it 'informs you of failure' do
      click_on 'Save score'
      expect(page).to have_text "Points achieved can't be blank"
    end
  end

  context 'when score is negative' do
    before do
      fill_in 'quiz_score_points_achieved', with: '-14'
    end

    it 'does not accept the score' do
      click_on 'Save score'
      expected = 'Points achieved must be greater than or equal to 0'
      expect(page).to have_text expected
    end
  end

  context 'when score is above the maximum' do
    let!(:max_score) do
      input = find_field 'quiz_score_total_points'
      input.value.to_i
    end
    let!(:bad_score) { (max_score + 1).to_s }

    before do
      fill_in 'quiz_score_points_achieved', with: bad_score
    end

    it 'does not accept positive number greater than total points' do
      click_on 'Save score'
      expected = "Points achieved must be less than or equal to #{max_score}"
      expect(page).to have_text expected
    end
  end
end
