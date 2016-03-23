class Bus < ActiveRecord::Base
  validates :number, presence: true
end
