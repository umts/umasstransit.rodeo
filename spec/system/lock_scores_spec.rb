# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'locking the scores' do
  before do
    create_list(:participant, 5)
    Settings.instance.update(scores_locked: true)
    when_current_user_is user
    visit scoreboard_participants_path
  end

  context 'when you are not priveliged' do
    let(:user) { create(:user) }

    it 'displays when the scores are locked' do
      expect(page).to have_text 'Scores are locked!'
    end

    it 'does not display the lock scores button' do
      expect(page).to have_no_text 'Unlock Scores'
    end
  end

  context 'when you are the master of ceremonies' do
    let(:user) { create(:user, :master_of_ceremonies) }

    it 'does not display when the scores are locked' do
      expect(page).to have_no_text 'Scores are locked!'
    end

    it 'displays the lock scores button' do
      expect(page).to have_text 'Unlock Scores'
    end

    it 'allows you to lock and unlock the scores' do
      expect { click_on 'Unlock Scores' }.to change(Settings, :scores_locked?)
    end
  end
end
