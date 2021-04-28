# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CircleCheckScoresChannel do
  before { subscribe }

  it 'subscribes' do
    expect(subscription).to be_confirmed
  end

  it 'streams from "update"' do
    expect(subscription).to have_stream_from 'circle_check_scores:update'
  end
end
