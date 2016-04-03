class FayeController < ApplicationController
  def test
    if request.get?
      render 'test'
    elsif request.post?
      PrivatePub.publish_to '/test', {}
    end
  end
end
