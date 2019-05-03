class CircleCheckScoresChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'circle_check_scores:update'
  end

  def unsubscribed
  end
end
