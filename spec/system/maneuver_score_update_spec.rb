# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'updating a maneuver score' do
  let(:maneuver) { create(:maneuver) }
  let(:mp) do
    create(:maneuver_participant, :perfect_score, maneuver:)
  end

  before do
    when_current_user_is :admin
  end

  context 'when updating a checkbox' do
    let(:field) { 'maneuver_participant_reversed_direction' }

    it 'updates the value' do
      visit maneuver_participant_path(mp.id)
      fill_in field, with: '1'
      click_on 'Save score'
      expect(page).to have_field(field, with: '1')
    end
  end

  context 'when updating an obstacle' do
    let!(:obstacle) { create(:obstacle, maneuver:) }
    let(:field) { "maneuver_participant_obstacle_#{obstacle.id}" }

    it 'updates obstacles hit with 1' do
      visit maneuver_participant_path(mp.id)
      fill_in field, with: '1'
      click_on 'Save score'
      expect(page).to have_field(field, with: '1')
    end
  end

  context 'when updating a distance target' do
    let!(:distance_target) { create(:distance_target, maneuver:) }
    let(:field) { "maneuver_participant_target_#{distance_target.id}" }

    it 'updates distance from target with 1' do
      visit maneuver_participant_path(mp.id)
      fill_in field, with: '1'
      click_on 'Save score'
      expect(page).to have_field(field, with: '1')
    end
  end
end
