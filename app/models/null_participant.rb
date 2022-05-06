# frozen_string_literal: true

class NullParticipant < Participant
  after_initialize :readonly!

  def number = 0

  def show_name? = false
end
