class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_paper_trail_whodunnit

  private

  def update_scoreboard(score)
    PrivatePub.publish_to '/scoreboard', score unless Rails.env.test?
  end
end
