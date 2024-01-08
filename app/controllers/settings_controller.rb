# frozen_string_literal: true

class SettingsController < ApplicationController
  def flip_scores_lock
    settings = Settings.instance
    if settings.update({ scores_locked: !settings.scores_locked })
      redirect_to scoreboard_participants_path,
                  notice: settings.scores_locked? ? t('.scores_locked') : t('.scores_unlocked')
    else
      redirect_to scoreboard_participants_path, alert: settings.errors.full_messages.to_sentence
    end
  end
end
