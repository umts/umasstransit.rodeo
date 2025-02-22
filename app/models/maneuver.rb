# frozen_string_literal: true

class Maneuver < ApplicationRecord
  has_many :maneuver_participants, dependent: :restrict_with_error
  has_many :participants, through: :maneuver_participants
  has_many :obstacles, dependent: :destroy
  has_many :distance_targets, dependent: :destroy

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :sequence_number, presence: true, uniqueness: true

  def grouped_obstacles
    obstacles.order(:id).group_by { |o| [o.point_value, o.obstacle_type] }
  end

  def image_path
    "maneuvers/#{name}.png"
  end

  def next_participant(number = nil)
    participants.order(:number).find_by('number > ?', number).presence ||
      Participant.numbered.order(:number).find do |p|
        !p.completed? self
      end
  end

  def previous_participant(number = nil)
    if number.present?
      participants.order(number: :desc).find_by(number: ...number)
    else
      participants.order(:number).last
    end
  end
end
