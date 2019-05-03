# frozen_string_literal: true

module ScoreboardPulisher
  extend ActiveSupport::Concern

  included do
    after_create :update_scoreboard
    after_update :update_scoreboard
  end

  private

  def update_scoreboard
    ScoreboardService.update with: self
  end
end
