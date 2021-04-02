# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'recording a new maneuver score' do
  let(:judge) { create :user, :judge }
  let(:maneuver) { create :maneuver }
  let(:participant) { create :participant }
  let(:mp) do
    ManeuverParticipant.find_by maneuver_id: maneuver,
                                participant_id: participant
  end

  before do
    when_current_user_is judge
    visit new_maneuver_participant_path maneuver: maneuver.name,
                                        participant: participant.number
  end

  it 'increases maneuver participant count by one' do
    expect { click_on 'Save & next' }.to change(ManeuverParticipant, :count).by(1)
  end

  it 'records the creator' do
    click_on 'Save & next'
    when_current_user_is :admin
    visit maneuver_participant_path(mp)
    expect(page).to have_text "recorded by #{judge.name}"
  end
end
