# frozen_string_literal: true

class Bus < ApplicationRecord
  has_many :participants, dependent: :nullify

  validates :number, uniqueness: { case_sensitive: false }, presence: true
end
