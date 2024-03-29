# frozen_string_literal: true

class ScoreboardRenderer < ParticipantsController
  module ScoreboardRendererHelper
    def current_user = nil
    def debug_assets = false
    def user_signed_in? = false
  end
  helper ScoreboardRendererHelper

  skip_forgery_protection

  class << self
    def assigns
      {
        archiving: true,
        can_edit_scores: false,
        maneuvers: Maneuver.order(:sequence_number),
        participants_exist: true,
        maneuver_participants: ManeuverParticipant.scoreboard_grouping,
        participants: Participant.scoreboard_data.scoreboard_order(nil)
      }
    end

    def render
      super(:scoreboard, assigns:)
    end
  end
end
