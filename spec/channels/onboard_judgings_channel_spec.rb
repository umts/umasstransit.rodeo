# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OnboardJudgingsChannel do
  it 'streams from "update"' do
    subscribe
    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_from 'onboard_judgings:update'
  end
end
