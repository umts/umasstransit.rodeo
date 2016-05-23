require 'rails_helper'

describe 'adding a bus' do
  before :each do
    when_current_user_is :admin
    visit buses_url
  end
  context 'with a number filled in' do
    it 'adds the bus' do
      fill_in 'bus_number', with: 'Big Yellow Bus'
      click_on 'Add'
      expect(page).to have_text 'Big Yellow Bus'
    end
  end
  context 'with a number not filled in' do
    it 'explains that number is needed' do
      click_on 'Add'
      expect(page).to have_text "Number can't be blank"
    end
  end
end
