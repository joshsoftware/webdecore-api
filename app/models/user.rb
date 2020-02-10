# frozen_string_literal: true

class User < ApplicationRecord
  validates :first_name, :last_name, :contact_number, :email, :password, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :themes
  has_many :user_animations
  has_many :animation_datas, through: :user_animations
end
