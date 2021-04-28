# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'updating a maneuver score' do
  let(:maneuver) { create :maneuver }
  let(:mp) do
    create :maneuver_participant, :perfect_score, maneuver: maneuver
  end

  before do
    when_current_user_is :admin
  end

  it 'updates the value' do
    visit maneuver_participant_path(mp.id)
    fill_in 'reversed_direction', with: '1'
    click_on 'Save score'
    expect(page).to have_field('reversed_direction', with: '1')
  end

  context 'when updating an obstacle' do
    let!(:obstacle) { create :obstacle, maneuver: maneuver }
    let(:field) { "obstacle_#{obstacle.id}" }

    it 'updates obstacles hit with 1' do
      visit maneuver_participant_path(mp.id)
      fill_in field, with: '1'
      click_on 'Save score'
      expect(page).to have_field(field, with: '1')
    end
  end

  context 'when updating a distance target' do
    let!(:distance_target) { create :distance_target, maneuver: maneuver }
    let(:field) { "target_#{distance_target.id}" }

    it 'updates distance from target with 1' do
      visit maneuver_participant_path(mp.id)
      fill_in field, with: '1'
      click_on 'Save score'
      expect(page).to have_field(field, with: '1')
    end
  end
end
