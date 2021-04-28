# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'updating a quiz score' do
  let(:field) { 'quiz_score_points_achieved' }
  let(:role) { :admin }

  before do
    create :quiz_score, points_achieved: 50, total_points: 100
    when_current_user_is role
    visit quiz_scores_path
  end

  context 'with admin privilege' do
    before { fill_in field, with: '70' }

    it 'updates quiz score' do
      click_on 'Save score'
      expect(page).to have_field(field, with: '70.0')
    end

    it 'informs you of success' do
      click_on 'Save score'
      expect(page).to have_text 'Quiz score was saved.'
    end
  end

  context 'with quiz scorer privilege' do
    let(:role) { :quiz_scorer }

    before { fill_in field, with: '70' }

    it 'updates quiz score' do
      click_on 'Save score'
      expect(page).to have_field(field, with: '70.0')
    end

    it 'informs you of success' do
      click_on 'Save score'
      expect(page).to have_text 'Quiz score was saved.'
    end
  end

  context 'with judge privilege' do
    let(:role) { :judge }

    before { fill_in field, with: '70' }

    it 'will not update quiz score' do
      click_on 'Save score'
      expect(page).to have_text 'You are not authorized to make that action.'
    end
  end

  context 'when quiz score is negative' do
    before { fill_in field, with: '-14' }

    it 'will not accept the score' do
      click_on 'Save score'
      expected = 'Points achieved must be greater than or equal to 0'
      expect(page).to have_text expected
    end
  end

  context 'when quiz score is above the maximum' do
    let!(:max_score) do
      input = find_field 'quiz_score_total_points'
      input.value.to_i
    end
    let!(:bad_score) { (max_score + 1).to_s }

    before { fill_in field, with: bad_score }

    it 'will not accept the score' do
      click_on 'Save score'
      expected = "Points achieved must be less than or equal to #{max_score}"
      expect(page).to have_text expected
    end
  end

  context 'when blank field quiz score' do
    before { fill_in field, with: '' }

    it 'will not accept blank number' do
      click_on 'Save score'
      expect(page).to have_text "Points achieved can't be blank"
    end
  end
end
