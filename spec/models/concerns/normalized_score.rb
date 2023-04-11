# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples_for 'a normalized score' do
  let(:field_name) { described_class.name.underscore }

  describe '.with_scores' do
    subject(:call) { described_class.select('*').with_scores }

    it 'includes the calculated column' do
      expect(call.find(score.id).attributes).to include(field_name)
    end

    it 'calculates the score correctly' do
      expect(call.find(score.id).send(field_name)).to eq(expected_score)
    end
  end

  describe '#score' do
    it 'has the correct value' do
      expect(score.score).to eq(expected_score)
    end

    it 'can get the calculation from the database' do
      allow(described_class).to receive(:with_scores)
        .and_return(described_class.select('*', "42 AS #{field_name}"))
      score_from_db = described_class.with_scores.find(score.id)
      expect(score_from_db.score).to eq(42)
    end
  end
end
