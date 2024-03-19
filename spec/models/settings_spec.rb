# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Settings do
  describe 'validations' do
    context 'singleton guard' do
      it 'should prevent the creation of more than one Settings instance' do
        expect(Settings.new.save).to be(false)
      end
    end
  end
end
