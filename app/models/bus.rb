class Bus < ActiveRecord::Base
  has_many :participants

  validates :number, presence: true
end
