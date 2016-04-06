class Bus < ActiveRecord::Base
  has_many :participants

  validates :number, uniquness: true, presense: true
end
