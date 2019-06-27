# frozen_string_literal: true

class OnboardJudgingsChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'onboard_judgings:update'
  end

  def unsubscribed; end
end
