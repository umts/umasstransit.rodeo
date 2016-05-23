require 'rails_helper'

describe 'making an unauthenticated request' do
  it 'redirects to the sign in page' do
    visit buses_url
    expect(page.current_url).to eql new_user_session_url
  end
end
