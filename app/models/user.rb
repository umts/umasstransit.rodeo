class User < ActiveRecord::Base
  has_paper_trail

  devise :database_authenticatable, :registerable
  validates :name, :email, presence: true, uniqueness: true
  validates :email, format: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates :encrypted_password, presence: true
  def has_role?(role)
    admin? || send(role)
  end
end
