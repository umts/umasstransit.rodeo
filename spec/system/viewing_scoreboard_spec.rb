# frozen_string_literal: true

require 'rails_helper'

RSpec.shared_examples 'they are not allowed to edit' do
  it 'shows participants' do
    expect(page).to have_text mp.participant.name
  end

  it 'shows scores' do
    expect(row).to have_text mp.score
  end

  it 'does not provide any links to edit' do
    expect(row).to have_no_link
  end
end

RSpec.describe 'viewing the scoreboard' do
  let(:mp) { create(:maneuver_participant) }
  let!(:participant) { mp.participant }
  let(:row) { find('tr', text: participant.name) }

  before do
    when_current_user_is user
    visit scoreboard_participants_path
  end

  context 'when not logged in' do
    let(:user) { nil }

    include_examples 'they are not allowed to edit'
  end

  context 'when not an admin' do
    let(:user) { :anybody }

    include_examples 'they are not allowed to edit'
  end

  context 'when an admin' do
    let(:user) { :admin }

    it 'provides links to edit completed scores' do
      expect(row).to have_link(text: mp.score)
    end

    it 'provides links to edit uncompleted scores' do
      expect(row).to have_link(text: '—')
    end
  end
end
