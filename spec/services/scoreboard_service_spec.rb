# frozen_string_literal: true

require 'rails_helper'

describe ScoreboardService do
  describe '.update' do
    %i[circle_check_score maneuver_participant
       onboard_judging participant quiz_score].each do |model|
      let!(model) { create model }
    end

    it 'broadcasts simple objects to their update channel' do
      expect { ScoreboardService.update with: circle_check_score }
        .to have_broadcasted_to('circle_check_scores:update')
        .from_channel(CircleCheckScoresChannel)

      expect { ScoreboardService.update with: maneuver_participant }
        .to have_broadcasted_to('maneuver_participants:update')
        .from_channel(ManeuverParticipantsChannel)

      expect { ScoreboardService.update with: onboard_judging }
        .to have_broadcasted_to('onboard_judgings:update')
        .from_channel(OnboardJudgingsChannel)

      expect { ScoreboardService.update with: quiz_score }
        .to have_broadcasted_to('quiz_scores:update')
        .from_channel(QuizScoresChannel)
    end

    it 'broadcasts Participants to the correct channel' do
      expect { ScoreboardService.update with: participant }
        .to have_broadcasted_to('participants:update')
        .from_channel(ParticipantsChannel)

      expect { ScoreboardService.update with: participant, type: :wibble }
        .to have_broadcasted_to('participants:wibble')
        .from_channel(ParticipantsChannel)
    end
  end
end
