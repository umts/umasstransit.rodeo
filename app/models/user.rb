class User < ActiveRecord::Base
  has_paper_trail

  devise :database_authenticatable, :registerable, :validatable
  validates :name, :email, presence: true, uniqueness: true
  validates :email, format: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates :encrypted_password, presence: true

  scope :unapproved, -> { where.not approved: true }

  def approve!
    update! approved: true
  end

  def has_role?(role)
    admin? || send(role)
  end

  # Require admins to approve users once they register.
  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    approved? ? super : :not_approved
  end
end
