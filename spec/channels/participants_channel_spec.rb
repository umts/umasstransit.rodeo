# frozen_string_literal: true

require 'rails_helper'

describe ParticipantsChannel do
  it 'streams from "add"' do
    subscribe
    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_from 'participants:add'
  end

  it 'streams from "update"' do
    subscribe
    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_from 'participants:update'
  end

  it 'streams from "remove"' do
    subscribe
    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_from 'participants:remove'
  end
end
