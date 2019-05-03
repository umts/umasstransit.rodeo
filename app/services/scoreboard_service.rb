# frozen_string_literal: true

module ScoreboardService
  class << self
    def update(with:, type: :update)
      case with
      when ManeuverParticipant
        update_maneuver_participant with
      when OnboardJudging
        update_onboard_judging with
      when Participant
        update_participant with, type
      end
    end

    def update_maneuver_participant(mp)
      ManeuverParticipantsChannel.broadcast_to 'update', mp
    end

    def update_onboard_judging(oj)
      OnboardJudgingsChannel.broadcast_to 'update', oj
    end

    def update_participant(participant, type)
      ParticipantsChannel.broadcast_to type,
        { event: type, participant: participant }
    end
  end
end
