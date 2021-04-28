# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'signing up' do
  before { visit new_user_registration_path }

  context 'with a blank email' do
    before do
      fill_in 'user_name', with: 'Foo Bar'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
    end

    it 'does not create the user' do
      expect { click_on 'Send request' }.not_to(change(User, :count))
    end
  end

  context 'with a blank password' do
    before do
      fill_in 'user_name', with: 'Foo Bar'
      fill_in 'user_email', with: 'foo@valid.com'
    end

    it 'does not create the user' do
      expect { click_on 'Send request' }.not_to(change(User, :count))
    end
  end

  context 'with a valid user' do
    before do
      fill_in 'user_name', with: 'Foo Bar'
      fill_in 'user_email', with: 'foo@valid.com'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
    end

    it 'creates the user' do
      expect { click_on 'Send request' }.to change(User, :count).by(1)
    end
  end

  context 'when awaiting approval' do
    before do
      create :participant
      when_current_user_is :anyone
      visit root_path
    end

    it 'allows the user to view scoreboard' do
      within 'nav' do
        expect(current_scope).to have_text 'Scoreboard'
      end
    end

    %w[Maneuver Circle\ Check Quiz
       Participants Buses Roles Manage\ Users].each do |nav_item|
      it "does not allow the user to visit the #{nav_item} page" do
        within 'nav' do
          expect(current_scope).not_to have_text(nav_item)
        end
      end
    end
  end
end
