require 'rails_helper'

describe 'recording a maneuver score' do
  let!(:judge) { create :user, :judge }
  let!(:maneuver) { create :maneuver }
  let!(:participant) { create :participant, name: 'blah' }
  before :each do
    when_current_user_is judge
    visit new_maneuver_participant_path(maneuver: maneuver.name,
                                        participant: participant.number)
  end
  it 'works' do
    expect { click_on 'Save & next' }
      .to change { ManeuverParticipant.count }
      .by 1
  end
  it 'records the creator' do
    click_on 'Save & next'
    when_current_user_is :admin
    visit maneuver_participant_path(ManeuverParticipant.last)
    expect(page).to have_text "recorded by #{judge.name}"
  end
  #   it 'updates' do
  #     click_on 'Save & next'
  #     when_current_user_is :admin
  #     visit maneuver_participant_path(id: participant.id)
  #     fill_in
  #     expect { click_on 'Save & next' }
  #       .to be {}
  #   end
end
