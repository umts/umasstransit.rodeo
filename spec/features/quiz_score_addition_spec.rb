require 'rails_helper'

describe 'adding a quiz score - admin' do 
	before :each do
		create :participant
		when_current_user_is :admin
		visit quiz_scores_url
	end
	context 'with a number filled in' do
		it 'adds the quiz score' do 
			fill_in 'quiz_score_points_achieved', with: '60'
			click_on 'Save score'
			expect(page).to have_text 'Quiz score was saved.'
			input = find_field :quiz_score_points_achieved
			expect(input.value).to eql '60.0'
		end
	end
end

describe 'adding a quiz score - quiz scorer' do 
	before :each do
		create :participant
		when_current_user_is :quiz_scorer
		visit quiz_scores_url
	end
	context 'with a number filled in' do
		it 'adds the quiz score' do 
			fill_in 'quiz_score_points_achieved', with: '50'
			click_on 'Save score'
			expect(page).to have_text 'Quiz score was saved.'
			input = find_field :quiz_score_points_achieved
			expect(input.value).to eql '50.0'
		end
	end
end

describe 'adding a quiz score - judge scorer' do 
	before :each do
		create :participant
		when_current_user_is :judge
		visit quiz_scores_url
	end
	context 'with a number filled in' do
		it 'adds the quiz score' do 
			fill_in 'quiz_score_points_achieved', with: '70'
			click_on 'Save score'
			expect(page).not_to have_text 'Quiz score was saved.'
		end
	end
end

describe 'updating a quiz score - quiz scorer' do 
	before :each do
		create :participant
		when_current_user_is :quiz_scorer
		visit quiz_scores_url
	end
	context 'with a number filled in' do
		it 'update the quiz score' do 
			fill_in 'quiz_score_points_achieved', with: '50'
			click_on 'Save score'
			expect(page).to have_text 'Quiz score was saved.'
			input = find_field :quiz_score_points_achieved
			expect(input.value).to eql '50.0'
			fill_in 'quiz_score_points_achieved', with: '70'
			click_on 'Save score'
			expect(page).to have_text 'Quiz score was saved.'
			input = find_field :quiz_score_points_achieved
			expect(input.value).to eql '70.0'
		end
	end
end	

describe 'updating a quiz score - admin' do 
	before :each do
		create :participant
		when_current_user_is :admin
		visit quiz_scores_url
	end
	context 'with a number filled in' do
		it 'update the quiz score' do 
			fill_in 'quiz_score_points_achieved', with: '50'
			click_on 'Save score'
			expect(page).to have_text 'Quiz score was saved.'
			input = find_field :quiz_score_points_achieved
			expect(input.value).to eql '50.0'
			fill_in 'quiz_score_points_achieved', with: '70'
			click_on 'Save score'
			expect(page).to have_text 'Quiz score was saved.'
			input = find_field :quiz_score_points_achieved
			expect(input.value).to eql '70.0'
		end
	end
end	