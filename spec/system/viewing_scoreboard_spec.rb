# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'viewing the scoreboard' do
  subject(:row) { find('tr', text: mp.participant.name) }

  let!(:mp) { create(:maneuver_participant) }

  before do
    when_current_user_is user
    visit scoreboard_participants_path
  end

  context 'when not logged in' do
    let(:user) { nil }

    it { is_expected.to have_text mp.score }
    it { is_expected.to have_no_link }
  end

  context 'when not an admin' do
    let(:user) { :anybody }

    it { is_expected.to have_text mp.score }
    it { is_expected.to have_no_link }
  end

  context 'when an admin' do
    let(:user) { :admin }

    it { is_expected.to have_link(text: mp.score) }
    it { is_expected.to have_link(text: '—') }
  end
end
