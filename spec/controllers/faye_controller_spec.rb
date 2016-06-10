require 'rails_helper'

describe FayeController do
  include Devise::TestHelpers
  before :each do
    user = create :user, admin: true
    sign_in user
  end
  context 'post #test' do
    it 'posts to faye test' do
      expect(PrivatePub).to receive(:publish_to).with('/test', anything)
      post :test
    end
  end
  context 'get #test' do
    it 'gets faye_test page' do
      get :test
      expect(response).to render_template(:test)
    end
  end
end
