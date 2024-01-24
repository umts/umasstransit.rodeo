# frozen_string_literal: true

module ScoreboardService
  class << self
    def update(with:, type: :update)
      case with
      when CircleCheckScore, ManeuverParticipant, OnboardJudging, QuizScore
        update_object with
      when Participant
        update_participant with, type
      end
    end

    private

    def update_object(object)
      channels[object.class].broadcast_to 'update', object
    end

    def update_participant(participant, type)
      ParticipantsChannel.broadcast_to type, event: type, participant:
    end

    def channels
      {
        CircleCheckScore => CircleCheckScoresChannel,
        ManeuverParticipant => ManeuverParticipantsChannel,
        OnboardJudging => OnboardJudgingsChannel,
        Participant => ParticipantsChannel,
        QuizScore => QuizScoresChannel
      }
    end
  end
end
