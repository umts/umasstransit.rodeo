# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ParticipantsChannel do
  before { subscribe }

  it 'subscribes' do
    expect(subscription).to be_confirmed
  end

  it 'streams from "add"' do
    expect(subscription).to have_stream_from 'participants:add'
  end

  it 'streams from "update"' do
    expect(subscription).to have_stream_from 'participants:update'
  end

  it 'streams from "remove"' do
    expect(subscription).to have_stream_from 'participants:remove'
  end
end
