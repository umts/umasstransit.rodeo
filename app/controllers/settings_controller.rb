# frozen_string_literal: true

class SettingsController < ApplicationController
  def update
    settings = Settings.instance
    if settings.update settings_params
      redirect_to scoreboard_participants_path,
                  notice: settings.scores_locked? ? t('.scores_locked') : t('.scores_unlocked')
    else
      redirect_to scoreboard_participants_path, notice: settings.errors.full_messages.to_sentence
    end
  end

  private

  def settings_params
    params.fetch(:settings, {}).permit(:scores_locked)
  end
end
