# frozen_string_literal: true

# rubocop:disable Rails/ApplicationController
class HealthController < ActionController::Base
  # rubocop:enable Rails/ApplicationController
  rescue_from(Exception) { render_down }

  def show = render_up

  private

  def render_up
    render html: html_status(message: 'UP'), status: :ok
  end

  def render_down
    render html: html_status(message: 'DOWN'), status: :internal_server_error
  end

  def html_status(message:)
    # This _is_ dangerous if `message` is not sanitized. But it only called above
    # with the strings 'UP' or 'DOWN'. This whole controller can go away after we
    # upgrade to Rails 7.1
    # rubocop:disable Rails/OutputSafety
    %(<!DOCTYPE html><html><body"><h1>#{message}</h1></body></html>).html_safe
    # rubocop:enable Rails/OutputSafety
  end
end
