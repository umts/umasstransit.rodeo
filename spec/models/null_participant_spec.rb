# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NullParticipant do
  subject(:np) { described_class.new(number: 999) }

  it 'is always read-only' do
    expect(np.readonly?).to be(true)
  end

  describe '#number' do
    it 'is always zero' do
      expect(np.number).to be_zero
    end
  end

  describe '#show_name?' do
    before { allow(Participant).to receive(:scoreboard_data) }

    it 'is always false' do
      expect(np.show_name?).to be(false)
    end

    it "doesn't even check" do
      expect(Participant).not_to have_received(:scoreboard_data)
    end
  end
end
