# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :confirmable

  validates :first_name, :last_name, presence: true
  valid_email_regex = /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i
  validates :email, presence: true, format: { with: valid_email_regex }, uniqueness: true
  valid_contact_regex = /\A[7-9][0-9]{9}\z/
  validates :contact_number, presence: true, format: { with: valid_contact_regex }, uniqueness: true
  validates :uuid, uniqueness: true
  has_many :user_animations, :dependent => :destroy
  has_many :animation_datas, :dependent => :destroy

  before_save :titleize_names

  def titleize_names
    self.first_name = self.first_name.titleize
    self.last_name = self.last_name.titleize
  end

  def password_match?
    self.errors[:password] << "Password can't be blank" if password.blank?
    self.errors[:password_confirmation] << "Password can't be blank" if password_confirmation.blank?
    self.errors[:password_confirmation] << "Password does not match" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end
end
