# frozen_string_literal: true

require 'app_form_builder'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action -> { @archiving = false }

  default_form_builder AppFormBuilder

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def deny_access
    flash[:alert] = 'You are not authorized to make that action.'
    redirect_back fallback_location: root_path
  end

  def require_role(role)
    deny_access && return unless current_user.role?(role)
  end
end
