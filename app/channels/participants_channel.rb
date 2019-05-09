# frozen_string_literal: true

class ParticipantsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'participants:add'
    stream_from 'participants:update'
    stream_from 'participants:remove'
  end

  def unsubscribed; end
end
