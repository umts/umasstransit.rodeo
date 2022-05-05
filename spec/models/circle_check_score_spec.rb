# frozen_string_literal: true

require 'rails_helper'
require_relative 'concerns/scoreboard_publisher'

RSpec.describe CircleCheckScore do
  subject(:score) do
    create :circle_check_score, total_defects: 5, defects_found: 2, participant: participant
  end

  let(:participant) { create :participant }

  it_behaves_like 'a scoreboard publisher'

  describe '.with_scores' do
    subject(:call) { described_class.select('*').with_scores }

    it 'includes the calculated column' do
      expect(call.find(score.id).attributes).to include('circle_check_score')
    end

    it 'calculates the score correctly' do
      expect(call.find(score.id).circle_check_score).to eq 20
    end
  end

  describe '#score' do
    it 'has the correct value' do
      expect(score.score).to eq 20
    end

    it 'can get the calculation from the database' do
      allow(score).to receive(:attributes).and_return({'circle_check_score' => 42})
      expect(score.score).to eq(42)
    end
  end
end
