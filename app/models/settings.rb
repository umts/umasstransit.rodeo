# frozen_string_literal: true

class Settings < ApplicationRecord
  validates :singleton_guard, inclusion: { in: [0] }, uniqueness: true

  def self.instance
    first_or_create!(singleton_guard: 0)
  end
end
