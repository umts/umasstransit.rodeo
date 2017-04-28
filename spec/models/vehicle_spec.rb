require 'rails_helper'

describe Vehicle do
  describe 'simple validations' do
    it 'prevents vehicles from having the same number' do
      create :vehicle, number: 'Yellow Van'
      invalid_vehicle = build :vehicle, number: 'Yellow Van'
      expect(invalid_vehicle).not_to be_valid
    end
  end
end
