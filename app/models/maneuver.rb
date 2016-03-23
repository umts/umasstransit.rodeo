class Maneuver < ActiveRecord::Base
  has_and_belongs_to_many :participants, through: :maneuver_participants
  has_many :obstacles
  has_many :distance_targets

  validates :name, :sequence_number, presence: true
end
