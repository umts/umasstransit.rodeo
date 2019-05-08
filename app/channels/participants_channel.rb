class ParticipantsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'participants:add'
    stream_from 'participants:update'
    stream_from 'participants:remove'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end