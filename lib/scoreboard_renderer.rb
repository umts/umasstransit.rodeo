# frozen_string_literal: true

class ScoreboardRenderer < ParticipantsController
  module ScoreboardRendererHelper
    def javascript_include_tag(*sources)
      options = sources.extract_options!.merge(debug: false)
      super(*sources, options)
    end

    def stylesheet_link_tag(*sources)
      options = sources.extract_options!.merge(debug: false)
      super(*sources, options)
    end
  end

  helper ScoreboardRendererHelper

  class << self
    def assigns
      {
        archiving: true,
        can_edit_scores: false,
        maneuvers: Maneuver.order(:sequence_number),
        participants: Participant.scoreboard_order(nil),
        scores: ManeuverParticipant.scoreboard_grouping
      }
    end

    def render
      super(:scoreboard, assigns: assigns)
    end
  end

  def flash
    {}
  end

  def protect_against_forgery?
    false
  end

  def user_signed_in?
    false
  end
end
