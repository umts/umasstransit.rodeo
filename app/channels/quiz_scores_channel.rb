class QuizScoresChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'quiz_scores:update'
  end

  def unsubscribed
  end
end
