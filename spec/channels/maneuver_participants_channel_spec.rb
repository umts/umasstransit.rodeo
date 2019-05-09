# frozen_string_literal: true

require 'rails_helper'

describe ManeuverParticipantsChannel do
  it 'streams from "update"' do
    subscribe
    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_from 'maneuver_participants:update'
  end
end
