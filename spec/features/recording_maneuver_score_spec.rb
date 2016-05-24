require 'rails_helper'

describe 'recording a maneuver score' do
  let!(:judge) { create :user, :judge }
  let!(:maneuver) { create :maneuver }
  let!(:participant) { create :participant }
  it 'records the creator' do
    when_current_user_is judge
    visit new_maneuver_participant_path(maneuver: maneuver.name,
                                        participant: participant.number)
    expect { click_on 'Save & next' }
      .to change { ManeuverParticipant.count }
      .by 1
    expect(ManeuverParticipant.last.creator).to eql judge
  end
end
