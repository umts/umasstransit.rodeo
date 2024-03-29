# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper do
  include Capybara::RSpecMatchers

  describe 'nav_item' do
    let(:path) { 'http://example.com/path' }
    let(:text) { 'My Link Text' }
    let(:call) { helper.nav_item(path, text, role: :admin) }

    before { allow(helper).to receive(:current_user).and_return user }

    context 'without required role' do
      let(:user) { create(:user) }

      it 'returns nil' do
        expect(call).to be_nil
      end
    end

    context 'with required role' do
      let(:user) { create(:user, :admin) }

      it 'links to the path' do
        expect(call).to have_link(href: path)
      end

      it 'contains the text' do
        expect(call).to have_link(text)
      end

      it 'yields a given block' do
        expect do |block|
          helper.nav_item(path, role: :admin, &block)
        end.to yield_control
      end
    end
  end
end
