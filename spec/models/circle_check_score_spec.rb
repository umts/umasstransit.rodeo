require 'rails_helper'

describe CircleCheckScore do 
	let(:participant) { create :participant }
	it 'score should get correct value' do 
		check_score = create :circle_check_score, participant: participant, total_defects: 5, defects_found: 4
		expect(check_score.score).to eql 40
	end
end
