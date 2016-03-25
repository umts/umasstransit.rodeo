class ManeuverParticipant < ActiveRecord::Base
  belongs_to :maneuver
  belongs_to :participant

  serialize :obstacles_hit, Hash
  serialize :distances_achieved, Hash

  before_validation :set_score, on: :create

  validates :maneuver, :participant, :score, :reversed_direction, presence: true

  private

  def set_score
    score = 50
    obstacles_hit.each do |point_value, count|
      score -= point_value * count
    end
    distances_achieved.each do |(minimum, multiplier), distance|
      # if distance is less than minimum, don't add anything
      score -= [0, (distance - minimum)].max * multiplier
    end
    score -= reversed_direction * 10
    score -= 25 if maneuver.speed_target.present? && !speed_achieved?
    score -= 25 if maneuver.counts_additional_stops? && made_additional_stops?
    # bound score between 0 and 50
    score = [0, [score, 50].min].max
    assign_attributes score: score
  end
end
