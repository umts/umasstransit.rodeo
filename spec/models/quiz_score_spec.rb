require 'rails_helper'

describe QuizScore do 
	let(:participant) { create :participant }
	it 'score should have the correct value' do 
		quiz = create :quiz_score, participant: participant, points_achieved: 50, total_points: 100
		expect(quiz.score).to eql 25.0
	end
end
