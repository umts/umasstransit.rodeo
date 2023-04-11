# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationRecord do
  describe '.cast_to_node' do
    subject(:call) { described_class.cast_to_node(expression) }

    context 'when given an Arel Node' do
      let(:expression) { Arel::Nodes::Node.new }

      it { is_expected.to be(expression) }
    end

    context 'when given an Arel Attribute' do
      let(:expression) { described_class.arel_table[:dummy_attribute] }

      it { is_expected.to be(expression) }
    end

    context 'when given a String' do
      let(:expression) { 'A STRING' }

      it { is_expected.to be_a(Arel::Nodes::SqlLiteral) }
      it { is_expected.to eq(expression) }
    end

    context 'when given anything else' do
      let(:expression) { :something_else }

      it 'raises an ArgumentError' do
        expect { call }.to raise_error(ArgumentError)
      end
    end
  end

  describe '.null_as_zero' do
    subject(:call) { described_class.null_as_zero('`thing`') }

    it { is_expected.to be_a(Arel::Nodes::NamedFunction) }

    it 'outputs the correct function' do
      expect(call.to_sql).to eq('IFNULL(`thing`, 0)')
    end
  end

  describe '.top?' do
    subject(:call) { described_class.top?('`thing`', top: 5) }

    it { is_expected.to be_a(Arel::Nodes::As) }

    it 'has an alias for the rhs' do
      expect(call.right).to eq('top_5')
    end

    it 'has a <= for the lhs' do
      expect(call.left).to be_a(Arel::Nodes::LessThanOrEqual)
    end

    it 'has a dense-rank window function' do
      expect(call.left.to_sql).to start_with('DENSE_RANK()')
    end

    it 'has the correct window' do
      expect(call.left.to_sql).to match(/OVER \(ORDER BY `thing`\)/)
    end
  end
end
