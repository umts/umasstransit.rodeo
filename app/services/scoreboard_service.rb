# frozen_string_literal: true

module ScoreboardService
  class << self
    def update(with:, type: :update)
      case with
      when ManeuverParticipant
        update_maneuver_participant
      when Participant
        update_participant with, type
      end
    end

    def update_maneuver_participant(mp)
      
    end

    def update_participant(participant, type)
      ParticipantsChannel.broadcast_to type,
        { event: type, participant: participant }
    end
  end
end
