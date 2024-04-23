# frozen_string_literal: true

class HealthController < ActionController::Base
  rescue_from(Exception) { render_down }

  def show = render_up

  private

  def render_up
    render html: html_status(message: "UP"), status: 200
  end

  def render_down
    render html: html_status(message: "DOWN"), status: 500
  end

  def html_status(message:)
    %(<!DOCTYPE html><html><body"><h1>#{message}</h1></body></html>).html_safe
  end
end
