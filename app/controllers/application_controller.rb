# frozen_string_literal: true

require 'app_form_builder'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit
  before_action :configure_permitted_parameters, if: :devise_controller?

  default_form_builder AppFormBuilder

  private

  def deny_access
    flash[:notice] = 'You are not authorized to make that action.'
    redirect_back fallback_location: root_path
  end

  def update_scoreboard(score)
    PrivatePub.publish_to '/scoreboard', score unless Rails.env.test?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
