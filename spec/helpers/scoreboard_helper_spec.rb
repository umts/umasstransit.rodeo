# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScoreboardHelper do
  describe '.sort_list' do
    before { create(:maneuver) }

    let(:asc) { 0 }
    let(:desc) { 1 }
    let(:man_count) do
      Maneuver.count + %i[onboard_judging man_subtotal].count
    end
    let(:score_count) { man_count + %i[circle_check quiz total].count }

    it 'sorts by total score by default' do
      expect(helper.sort_list(nil)).to eq(helper.sort_list(:total_score))
    end

    it 'sorts by total score, descending' do
      expect(helper.sort_list(:total_score)).to eq([[score_count, desc]])
    end

    it 'sorts by maneuver score, descending' do
      expect(helper.sort_list(:maneuver_score)).to eq([[man_count, desc]])
    end

    it 'sorts by participant score, ascending' do
      expect(helper.sort_list(:participant_number)).to eq([[0, asc]])
    end
  end

  describe '.score_data' do
    let(:call) { helper.score_data(nil) }

    it 'is a hash' do
      expect(call).to be_a(Hash)
    end

    it 'has a text and score' do
      expect(call.keys).to contain_exactly(:text, :score)
    end

    context 'without a record' do
      it 'has a very negative text' do
        expect(call.fetch(:text)).to be < -1000
      end

      it 'has a zero score' do
        expect(call.fetch(:score)).to be_zero
      end
    end

    context 'with a record' do
      let(:record) { Struct.new(:score).new(42) }
      let(:call) { helper.score_data(record) }

      it 'has a text of the score of the record' do
        expect(call.fetch(:text)).to be 42
      end

      it 'has a score of the score of the record' do
        expect(call.fetch(:score)).to be 42
      end
    end
  end
end
