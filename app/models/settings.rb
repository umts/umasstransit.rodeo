# frozen_string_literal: true

require 'singleton'

class Settings < ApplicationRecord
  validates :singleton_guard, inclusion: { in: [0] }

  def self.instance
    first_or_create!(singleton_guard: 0)
  end
end
