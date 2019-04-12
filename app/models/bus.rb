class Bus < ApplicationRecord
  has_many :participants

  validates :number, uniqueness: true, presence: true
end
