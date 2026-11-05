# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'live scoreboard updates', :js do
  include SubscriptionHelper

  let(:cell) do
    lambda do |participant, type|
      td = if type.is_a? Maneuver
             "td[data-maneuver-id='#{type.id}']"
           else
             "td.#{type}"
           end
      find("tr[data-participant-id='#{participant.id}'] #{td}")
    end
  end

  let!(:participant) { create(:participant) }
  let(:maneuvers) { create_list(:maneuver, 3) }
  let!(:maneuver) { maneuvers.first }

  before do
    previous_connections = ActionCable.server.connections.dup
    visit scoreboard_participants_path
    wait_for_scoreboard_subscriptions(previous_connections)
  end

  %w[circle-check-score quiz-score onboard-judging].each do |score|
    it "starts out with a blank #{score}" do
      expect(cell[participant, score]).to have_text('—')
    end
  end

  it 'updates a circle-check score' do
    create(:circle_check_score, participant:, total_defects: 10, defects_found: 2)

    expect(cell[participant, 'circle-check-score']).to have_text('10.0')
  end

  it 'updates a quiz score' do
    create(:quiz_score, participant:, total_points: 100, points_achieved: 44)

    expect(cell[participant, 'quiz-score']).to have_text('22.0')
  end

  it 'updates an onboard-judging score' do
    create(:onboard_judging, participant:, missed_horn_sounds: 1)

    expect(cell[participant, 'onboard-judging']).to have_text('47')
  end

  it 'updates a maneuver score' do
    create(:maneuver_participant, :perfect_score, maneuver:, participant:, reversed_direction: 1)

    expect(cell[participant, maneuver]).to have_text('40')
  end

  it 'updates the total maneuver score' do
    create(:maneuver_participant, :perfect_score, maneuver:, participant:, obstacles_hit: { tree: [5, 1] })
    create(:maneuver_participant, :perfect_score, maneuver: maneuvers[1], participant:)

    expect(cell[participant, 'maneuver-score']).to have_text('95')
  end

  it 'updates the total score' do
    create(:quiz_score, participant:, total_points: 100, points_achieved: 44)
    create(:onboard_judging, participant:, missed_horn_sounds: 1)
    create(:maneuver_participant, :perfect_score, maneuver:, participant:, obstacles_hit: { rock: [5, 3] })

    expect(cell[participant, 'total-score']).to have_text((22 + 47 + 35).to_f)
  end

  it 'adds a participant' do
    new_participant = create(:participant, name: 'Joe Participant')

    expect(page).to have_css("tr[data-participant-id='#{new_participant.id}']", text: 'Joe Participant')
  end

  it 'updates a participant' do
    participant.update!(name: 'Newname Johnson')

    expect(page).to have_css("tr[data-participant-id='#{participant.id}']", text: 'Newname Johnson')
  end

  it 'removes a participant' do
    participant.destroy!

    expect(page).to have_css("tr[data-participant-id='#{participant.id}']")
  end
end
