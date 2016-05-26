class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit

  private

  def deny_access
    flash[:notice] = 'You are not authorized to make that action.'
    redirect_to :back
  end

  def update_scoreboard(score)
    unless Rails.env.test?
      PrivatePub.publish_to '/scoreboard', score
    end
  end
end
