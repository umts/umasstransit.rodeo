class Participant < ActiveRecord::Base
  belongs_to :bus
  has_and_belongs_to_many :maneuvers

  validates :name, :number, :bus, presence: true

  def self.next_number
    last_number = pluck(:number).sort.last || 0
    last_number + 1
  end
end
