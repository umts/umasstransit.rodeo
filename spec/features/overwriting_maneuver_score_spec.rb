require 'rails_helper'

describe 'overwriting a maneuver score' do
  let(:record) { create :maneuver_participant }
  context 'accessing the new page for an existing score' do
    before :each do
      when_current_user_is :judge
      visit new_maneuver_participant_path(
        maneuver: record.maneuver.name,
        participant: record.participant.number
      )
    end
    it 'redirects you to the show page' do
      expect(page.current_url).to eql maneuver_participant_url(record)
    end
  end
end
