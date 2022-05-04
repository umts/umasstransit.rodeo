# frozen_string_literal: true

class ScoreboardRenderer < ParticipantsController
  module ScoreboardRendererHelper
    def debug_assets
      false
    end

    def user_signed_in?
      false
    end
  end
  helper ScoreboardRendererHelper

  skip_forgery_protection

  class << self
    def assigns
      {
        archiving: true,
        can_edit_scores: false,
        maneuvers: Maneuver.order(:sequence_number),
        participants: Participant.scoreboard_data.scoreboard_order(nil)
      }
    end

    def render
      super(:scoreboard, assigns: assigns)
    end
  end
end
