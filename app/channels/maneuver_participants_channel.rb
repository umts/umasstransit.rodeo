class ManeuverParticipantsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'maneuver_participants:update'
  end

  def unsubscribed
  end
end
