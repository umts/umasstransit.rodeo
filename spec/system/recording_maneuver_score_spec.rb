# frozen_string_literal: true

require 'rails_helper'

describe 'recording a maneuver score' do
  let!(:judge) { create :user, :judge }
  let!(:maneuver) { create :maneuver }
  let!(:participant) { create :participant }
  before :each do
    when_current_user_is judge
    visit new_maneuver_participant_path(maneuver: maneuver.name,
                                        participant: participant.number)
  end
  it 'increases maneuver participant count by one' do
    expect { click_on 'Save & next' }
      .to change { ManeuverParticipant.count }
      .by 1
  end
  it 'records the creator' do
    click_on 'Save & next'
    when_current_user_is :admin
    visit maneuver_participant_path(ManeuverParticipant.last)
    expect(page).to have_text "recorded by #{judge.name}"
  end
end

describe 'updating a maneuver score' do
  let!(:maneuver_participant) do
    create :maneuver_participant, :perfect_score
  end
  it 'updates the value' do
    when_current_user_is :admin
    visit maneuver_participant_path(maneuver_participant.id)
    fill_in 'reversed_direction', with: '1'
    click_on 'Save score'
    input = find_field :reversed_direction
    expect(input.value).to eql '1'
  end
end

describe 'updating obstacles and distance targets' do
  let!(:maneuver) { create :maneuver }
  let!(:obstacle) { create :obstacle, maneuver: maneuver }
  let!(:distance_target) { create :distance_target, maneuver: maneuver }
  let!(:maneuver_participant) do
    create :maneuver_participant,
           maneuver: maneuver
  end
  it 'updates obstacles hit with 1' do
    when_current_user_is :admin
    visit maneuver_participant_path(maneuver_participant.id)
    fill_in "obstacle_#{obstacle.id}", with: '1'
    click_on 'Save score'
    input = find_field "obstacle_#{obstacle.id}"
    expect(input.value).to eql '1'
  end

  it 'updates distance from target with 1' do
    when_current_user_is :admin
    visit maneuver_participant_path(maneuver_participant.id)
    fill_in "target_#{distance_target.id}", with: '1'
    click_on 'Save score'
    input = find_field "target_#{distance_target.id}"
    expect(input.value).to eql '1'
  end
end
