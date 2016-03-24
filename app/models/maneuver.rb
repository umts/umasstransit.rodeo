class Maneuver < ActiveRecord::Base
  has_many :maneuver_participants
  has_many :obstacles
  has_many :distance_targets

  validates :name, :sequence_number, presence: true, uniqueness: true

  def image_path
    "maneuvers/#{name}.png"
  end

  def next_participant
    Participant.includes(:maneuver_participants).find do |participant|
      !participant.maneuver_participants.pluck(:maneuver_id).include? id
    end
  end

  def grouped_obstacles
    obstacles.group_by { |o| [o.point_value, o.obstacle_type] }
  end
end
