class User < ActiveRecord::Base
  has_paper_trail

  devise :database_authenticatable, :registerable, :validatable
  validates :name, :email, presence: true, uniqueness: true

  def has_role?(role)
    admin? || send(role)
  end
end
