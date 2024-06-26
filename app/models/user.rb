# frozen_string_literal: true

class User < ApplicationRecord
  has_paper_trail

  devise :database_authenticatable, :registerable, :validatable
  validates :name, :email, presence: true, uniqueness: { case_sensitive: false }
  validates :email, format: /\A[^@]+@([^@.]+\.)+[^@.]+\z/
  validates :encrypted_password, presence: true

  scope :unapproved, -> { where.not approved: true }

  def approve!
    update! approved: true, judge: true
  end

  def role?(role)
    admin? || ((master_of_ceremonies? || !Settings.scores_locked?) && send(role))
  end

  # Require admins to approve users once they register.
  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    approved? ? super : :not_approved
  end
end
