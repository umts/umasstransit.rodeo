require 'rails_helper' 

describe ParticipantsController do 
  include Devise::TestHelpers
  describe 'creating scoreboard' do 
    context 'partial' do 
      it 'tests something' do 
        create :participant 
        user = create :user
        get :scoreboard_partial, id: user, sort_order: 'total_score'
        expect(response).to render_template(:_scoreboard_partial)
      end
    end
  end
end