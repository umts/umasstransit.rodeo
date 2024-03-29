# frozen_string_literal: true

class SettingsController < ApplicationController
  def toggle_scores_lock
    settings = Settings.instance
    if settings.toggle(:scores_locked).save
      redirect_to scoreboard_participants_path,
                  notice: settings.scores_locked? ? t('.scores_locked') : t('.scores_unlocked')
    else
      redirect_to scoreboard_participants_path, alert: settings.errors.full_messages.to_sentence
    end
  end
end
