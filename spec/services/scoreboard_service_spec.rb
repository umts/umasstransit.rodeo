# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScoreboardService do
  describe '.update' do
    scores = %i[circle_check_score maneuver_participant onboard_judging quiz_score]
    scores.each { |model| let!(model) { create model } }
    let!(:participant) { create :participant }

    scores.each do |score|
      it "broadcasts #{score}s to their update channel" do
        chanel = "#{score.to_s.camelize}sChannel".constantize
        expect { described_class.update with: send(score) }
          .to have_broadcasted_to("#{score}s:update").from_channel(chanel)
      end
    end

    it 'broadcasts Participants to the correct channel with a default type, update' do
      expect { described_class.update with: participant }
        .to have_broadcasted_to('participants:update').from_channel(ParticipantsChannel)
    end

    it 'broadcasts Participants to the correct channel with a specified type' do
      expect { described_class.update with: participant, type: :wibble }
        .to have_broadcasted_to('participants:wibble').from_channel(ParticipantsChannel)
    end
  end
end
