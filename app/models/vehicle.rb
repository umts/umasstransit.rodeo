class Vehicle < ActiveRecord::Base
  has_many :participants

  validates :number, uniqueness: true, presence: true
end
