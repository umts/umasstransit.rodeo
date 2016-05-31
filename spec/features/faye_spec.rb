require 'rails_helper'
describe 'faye runs properly' do
  it 'will pass the test' do
    when_current_user_is :admin
    visit faye_test_url
    click_button 'Test Faye'
    expect(page).to have_text 'Success!'
  end
end
