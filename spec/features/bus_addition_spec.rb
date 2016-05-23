require 'rails_helper'

describe 'adding a bus' do
  before :each do
    when_current_user_is :admin
    visit buses_url
  end
  context 'with a number filled in' do
    it 'adds the bus' do
      # TEST GOES HERE
    end
  end
  context 'with a number not filled in' do
    it 'explains that number is needed'
  end
end
