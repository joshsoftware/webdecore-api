# frozen_string_literal: true

class User < ApplicationRecord
  validates :first_name, :last_name, :password, presence: true
  valid_email_regex = /\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i
  validates :email, presence: true, format: { with: valid_email_regex }, uniqueness: true
  validates :contact_number, length: { is: 10}, uniqueness: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :themes, :dependent => :destroy
  has_many :user_animations, :dependent => :destroy
  has_many :animation_datas, through: :user_animations, :dependent => :destroy

  before_save :titleize_names

  def titleize_names
    self.first_name = self.first_name.titleize
    self.last_name = self.last_name.titleize
  end

end
