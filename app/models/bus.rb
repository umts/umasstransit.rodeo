# frozen_string_literal: true

class Bus < ApplicationRecord
  has_many :participants, dependent: :nullify

  validates :number, uniqueness: true, presence: true
end
