require 'rails_helper'
describe 'recording an onboard judging score' do
  let(:judge) { create :user, :judge }
  let(:participant) { create :participant }
  it 'records the creator' do
    when_current_user_is judge
    visit new_onboard_judging_path(participant: participant.number)
    expect { click_on 'Save' }
      .to change { OnboardJudging.count }
      .by 1
    expect(OnboardJudging.last.creator).to eql judge
  end
end
