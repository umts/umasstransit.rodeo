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
    %(<!DOCTYPE html><html><body"><h1>#{message}</h1></body></html>).html_safe
  end
end
