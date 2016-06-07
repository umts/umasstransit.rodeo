require 'rails_helper'

describe Admin::UsersController do
  include Devise::TestHelpers
  describe 'update' do
    context 'bad PUT #UPDATE' do
      it 'will not update name or email' do
        request.env['HTTP_REFERER'] = admin_users_url
        user = create :user, admin: true
        sign_in user
        attrs = FactoryGirl.attributes_for(:user, name: '')
        put :update, id: user, user: attrs
        user.reload
        expected = ["Name can't be blank"]
        expect(response).to redirect_to(:admin_users)
        expect(flash[:errors]).to match(expected)
      end
    end
  end
end
