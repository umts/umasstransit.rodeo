class Bus < ActiveRecord::Base
  has_many :participants

  validates :number, uniqueness: true, presense: true
end
