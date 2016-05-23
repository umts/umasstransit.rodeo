require 'rails_helper'

describe User do
	describe 'simple validations' do
		it 'prevents users from having the same email' do
			create :user, name: 'Bob Smith', email: 'bsmith@example.com'
			invalid_user = build :user, name: 'Foo Bar', email: 'bsmith@example.com'
			expect(invalid_user).not_to be_valid
		end
	end
end
