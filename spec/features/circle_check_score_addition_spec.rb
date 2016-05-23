require 'rails_helper'

describe 'adding a circle check score - admin' do 
	before :each do 
		create :participant
		when_current_user_is :admin
		visit circle_check_scores_url
	end
	context 'with a number filled in' do 
		it 'add circle check score' do 
			fill_in 'circle_check_score_defects_found', with: '4'
			click_on 'Save score'
			expect(page).to have_text 'Score was saved.'
			input = find_field :circle_check_score_defects_found
			expect(input.value).to eql '4'
		end
	end
end

describe 'adding a circle check score - circle check scorer' do 
	before :each do 
		create :participant
		when_current_user_is :circle_check_scorer
		visit circle_check_scores_url
	end
	context 'with a number filled in' do 
		it 'add circle check score' do 
			fill_in 'circle_check_score_defects_found', with: '4'
			click_on 'Save score'
			expect(page).to have_text 'Score was saved.'
			input = find_field :circle_check_score_defects_found
			expect(input.value).to eql '4'
		end
	end
end

describe 'adding a circle check score - judge' do 
	before :each do 
		create :participant
		when_current_user_is :judge
		visit circle_check_scores_url
	end
	context 'with a number filled in' do 
		it 'add circle check score' do 
			fill_in 'circle_check_score_defects_found', with: '4'
			click_on 'Save score'
			expect(page).not_to have_text 'Score was saved.'
		end
	end
end