# frozen_string_literal: true

class ManeuverParticipant < ApplicationRecord
  has_paper_trail

  belongs_to :maneuver
  belongs_to :participant
  validates :maneuver, uniqueness: { scope: :participant }

  serialize :obstacles_hit, Hash
  serialize :distances_achieved, Hash

  before_validation :set_score

  validates :maneuver, :participant, :score, :reversed_direction, presence: true

  def creator
    user_id = versions.find_by(event: 'create').whodunnit
    User.find_by id: user_id if user_id
  end

  def self.scoreboard_grouping
    grouping = {}
    ManeuverParticipant.all.group_by(&:participant_id).each_pair do |pid, mps|
      grouping[pid] = mps.group_by(&:maneuver_id)
    end
    grouping
  end

  private

  # rubocop:disable Metrics/AbcSize
  def set_score
    score = 50
    obstacles_hit.each do |_obstacle_id, values_array|
      # values array is [point_value, times hit]
      score -= values_array.first * values_array.last
    end
    distances_achieved.each do |(minimum, multiplier), distance|
      # if distance is less than minimum, don't add anything
      score -= [0, (distance - minimum)].max * multiplier
    end
    score -= reversed_direction * 10
    score -= 25 if maneuver.speed_target.present? && !speed_achieved?
    score -= 25 if maneuver.counts_additional_stops? && made_additional_stops?
    score -= 50 unless completed_as_designed?
    # bound score between 0 and 50
    score = [0, [score, 50].min].max
    assign_attributes score: score
  end
  # rubocop:enable Metrics/AbcSize
end
