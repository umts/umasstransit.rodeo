# frozen_string_literal: true

require 'rails_helper'

describe QuizScoresChannel do
  it 'streams from "update"' do
    subscribe
    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_from 'quiz_scores:update'
  end
end
