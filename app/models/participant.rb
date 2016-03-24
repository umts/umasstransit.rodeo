class Participant < ActiveRecord::Base
  belongs_to :bus
  has_many :maneuver_participants

  validates :name, :number, presence: true, uniqueness: true
  validates :bus, presence: true

  default_scope { order :number }

  def self.next_number
    last_number = pluck(:number).sort.last || 0
    last_number + 1
  end
end
