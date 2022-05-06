# frozen_string_literal: true

class ManeuverParticipant < ApplicationRecord
  MIN_SCORE = 0
  MAX_SCORE = 50

  REVERSE_PENALTY = 10
  SPEED_PENALTY = 25
  STOP_PENALTY = 25
  CAD_PENALTY = 50

  include ScoreboardPublisher

  has_paper_trail

  belongs_to :maneuver
  belongs_to :participant

  serialize :obstacles_hit, Hash
  serialize :distances_achieved, Hash

  validates :maneuver, uniqueness: { scope: :participant }
  validates :score, :reversed_direction, presence: true

  before_validation :set_score

  def self.participant_sums
    select('`participant_id`', 'SUM(`score`) AS maneuver_sum').group(:participant_id)
  end

  def self.scoreboard_grouping
    all.group_by(&:participant_id).transform_values do |mps|
      mps.group_by(&:maneuver_id).transform_values(&:first)
    end
  end

  def creator
    user_id = versions.find_by(event: 'create').whodunnit
    User.find_by id: user_id if user_id
  end

  private

  def set_score
    score = MAX_SCORE - obstacle_penalty - distance_penalty - reverse_penalty -
            speed_penalty - additional_stops_penalty - cad_penalty
    assign_attributes score: score.clamp(MIN_SCORE, MAX_SCORE)
  end

  def additional_stops_penalty
    maneuver.counts_additional_stops? && made_additional_stops? ? STOP_PENALTY : 0
  end

  def cad_penalty
    completed_as_designed? ? 0 : CAD_PENALTY
  end

  def distance_penalty
    distances_achieved.each.sum do |(minimum, multiplier), distance|
      [0, (distance - minimum)].max * multiplier
    end
  end

  def obstacle_penalty
    obstacles_hit.each_value.sum { |points, count| points * count }
  end

  def reverse_penalty
    reversed_direction * REVERSE_PENALTY
  end

  def speed_penalty
    maneuver.speed_target.present? && !speed_achieved? ? SPEED_PENALTY : 0
  end
end
