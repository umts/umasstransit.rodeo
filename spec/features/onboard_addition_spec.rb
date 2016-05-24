require 'rails_helper'
	describe 'Adding onboard judging' do
		let!(:participant) {create :participant}
		let!(:bus) { create :bus }
		context'with admin privilidge' do
			it 'adds onboard score' do
				when_current_user_is :admin
				visit participant_url 
				visit select_participant_onboard_judgings_url
				click_on 'Judge'
				fill_in 'onboard_judging_minuites_elapsed', with: '7'
				fill_in 'onboard_judging_missed_turn_signals', with: '2'
				fill_in 'onboard_judging_sudden_stops', with: '1'
				click_on 'Save'
				expect(page).to have_text 'Onboard score has been saved.'
		end
	end 
end