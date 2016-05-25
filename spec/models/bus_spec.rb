require 'rails_helper'

describe Bus do
  describe 'simple validations' do
    it 'prevents buses from having the same number' do
      create :bus, number: 'Yellow Bus'
      invalid_bus = build :bus, number: 'Yellow Bus'
      expect(invalid_bus).not_to be_valid
    end
  end
end
