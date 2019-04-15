# frozen_string_literal: true

require 'rails_helper'
describe DistanceTarget do
  describe 'interval_type' do
    context 'when interval attribute is 0' do
      it 'returns inches' do
        target = create :distance_target, intervals: 0
        expect(target.interval_type).to eql 'inches'
      end
    end
    context 'when interval attribute is non-zero' do
      it 'returns marks' do
        target = create :distance_target, intervals: 1
        expect(target.interval_type).to eql 'marks'
      end
    end
  end
  describe 'index' do
    it 'returns index of distance target relative to itself' do
      maneuver = create :maneuver
      target1 = create :distance_target, maneuver: maneuver
      target2 = create :distance_target, maneuver: maneuver
      expect(target1.index).to eql 0
      expect(target2.index).to eql 1
    end
  end
end
