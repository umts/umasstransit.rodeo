# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Settings do
  describe 'validations' do
    it 'prevents the creation of more than one Settings instance' do
      expect(described_class.new.save).to be(false)
    end
  end
end
