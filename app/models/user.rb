class User < ActiveRecord::Base
  has_paper_trail

  devise :database_authenticatable, :registerable, :validatable
  validates :name, :email, presence: true, uniqueness: true
  validates :email, format: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates :encrypted_password, presence: true

  def has_role?(role)
    admin? || send(role)
  end

  # Require admins to approve users once they register.
  def active_for_authentication
    super && approved?
  end

  def inactive_message
    if !approved then :not_approved
    else super
    end
  end
end
