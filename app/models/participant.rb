class Participant < ActiveRecord::Base
  validates :name, :number, presence: true

  def self.next_number
    last_number = pluck(:number).sort.last || 0
    last_number + 1
  end
end
