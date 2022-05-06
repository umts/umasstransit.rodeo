# frozen_string_literal: true

require 'rails_helper'
require_relative 'concerns/normalized_score'
require_relative 'concerns/scoreboard_publisher'

RSpec.describe CircleCheckScore do
  subject(:score) do
    create :circle_check_score, total_defects: 5, defects_found: 2, participant: participant
  end

  let(:expected_score) { 20 }
  let!(:participant) { create :participant }

  it_behaves_like 'a scoreboard publisher'
  it_behaves_like 'a normalized score'
end
