# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'overwriting a maneuver score' do
  let(:record) { create(:maneuver_participant) }

  context 'when accessing the new page for an existing score' do
    let(:mp_path) do
      new_maneuver_participant_path maneuver: record.maneuver.name,
                                    participant: record.participant.number
    end

    before do
      when_current_user_is :judge
      visit mp_path
    end

    it 'redirects you to the show page' do
      expect(page).to have_current_path maneuver_participant_path(record)
    end
  end
end
