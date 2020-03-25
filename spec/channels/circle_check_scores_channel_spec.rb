# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CircleCheckScoresChannel do
  it 'streams from "update"' do
    subscribe
    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_from 'circle_check_scores:update'
  end
end
