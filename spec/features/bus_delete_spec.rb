require 'rails_helper'

describe 'deleting a bus - admin' do 
	before :each do 
		create :bus
		when_current_user_is :admin
		visit buses_url
	end
	context 'with admin privelege' do 
		it 'delete a bus' do 
			expect(page).to have_text 'Bus 1'
			click_on 'Remove'
			expect(page).not_to have_text 'Bus 1'
		end
	end
end

describe 'deleting a bus - master of ceremonies' do 
	before :each do 
		create :bus
		when_current_user_is :master_of_ceremonies
		visit buses_url
	end
	context 'with admin privelege' do 
		it 'delete a bus' do 
			expect(page).to have_text 'Bus 1'
			click_on 'Remove'
			expect(page).not_to have_text 'Bus 1'
		end
	end
end

describe 'deleting a bus - judge' do 
	before :each do 
		create :bus
		when_current_user_is :judge
		visit buses_url
	end
	context 'with admin privelege' do 
		it 'delete a bus' do 
			expect(page).not_to have_text 'Bus 1'
			click_on 'Remove'
			expect(page).to have_text 'Bus 1'
		end
	end
end