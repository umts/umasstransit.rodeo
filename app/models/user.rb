class User < ActiveRecord::Base
  has_paper_trail

  devise :database_authenticatable, :registerable
  validates :name, :email, presence: true, uniqueness: true
  validates :email, format: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validate do |user|
    if user.encrypted_password.blank?
      user.errors[:base] << "Password can't be blank."
    end
  end
  def has_role?(role)
    admin? || send(role)
  end
end
