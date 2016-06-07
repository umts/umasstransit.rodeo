require 'rails_helper' 

describe UsersController do 
  describe 'update' do 
    context 'bad POST #UPDATE' do 
      it 'displays error message' do 
        user = create :user
        