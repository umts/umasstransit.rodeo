class Maneuver < ApplicationRecord
  has_many :maneuver_participants
  has_many :participants, through: :maneuver_participants
  has_many :obstacles
  has_many :distance_targets

  validates :name, :sequence_number, presence: true, uniqueness: true

  def grouped_obstacles
    obstacles.order(:id).group_by { |o| [o.point_value, o.obstacle_type] }
  end

  def image_path
    "maneuvers/#{name}.png"
  end

  def next_participant(number = nil)
    participant = participants.find_by('number > ?', number) if number.present?
    unless participant.present?
      participant = Participant.numbered.order(:number).find do |p|
        !p.has_completed? self
      end
    end
    participant
  end

  def previous_participant(number = nil)
    if number.present?
      participants.where('number < ?', number).last
    else participants.last
    end
  end
end
