require 'rails_helper'

describe FayeController do
  before :each do
    current_user = create :user, :admin
    sign_in current_user
  end
  context 'post #test' do
    it 'posts to faye test' do
      expect(PrivatePub).to receive(:publish_to).with('/test', {})
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
