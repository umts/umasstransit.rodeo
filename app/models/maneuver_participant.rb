class ManeuverParticipant < ActiveRecord::Base
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
    if user_id
      User.find_by id: user_id
    end
  end

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
    score -= 50 unless completed_as_designed?
    # bound score between 0 and 50
    score = [0, [score, 50].min].max
    assign_attributes score: score
  end
end
