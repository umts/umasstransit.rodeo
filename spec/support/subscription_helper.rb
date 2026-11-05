# frozen_string_literal: true

module SubscriptionHelper
  def wait_for_scoreboard_subscriptions(previous_connections = [])
    Timeout.timeout(Capybara.default_max_wait_time) do
      sleep 0.01 until subscribed_to_scoreboard?(previous_connections)
    end
  end

  private

  def subscribed_to_scoreboard?(previous_connections)
    (scoreboard_channels - subscribed_channels(previous_connections)).empty?
  end

  def scoreboard_channels
    %w[
      CircleCheckScoresChannel
      ManeuverParticipantsChannel
      OnboardJudgingsChannel
      ParticipantsChannel
      QuizScoresChannel
    ]
  end

  def subscribed_channels(previous_connections)
    connection = (ActionCable.server.connections - previous_connections).last
    return [] unless connection

    connection.subscriptions.identifiers.filter_map { |identifier| JSON.parse(identifier)['channel'] }
  end
end
