class User < ActiveRecord::Base
  has_paper_trail

  devise :database_authenticatable
  validates :name, :email, presence: true, uniqueness: true

  def confirmation_required?
    false
  end
end
