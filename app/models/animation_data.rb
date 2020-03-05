# frozen_string_literal: true

class AnimationData < ApplicationRecord
  validates :animation_name, :animation_price, :picture, :animation_json, presence: true
  mount_uploader :picture, PictureUploader
  belongs_to :category, optional: true
  belongs_to :user
  has_many :user_animations
  has_many :users, through: :user_animations

  def user_private_animation?
    category_id.nil?
  end

  def purchase_private_animation?
    user_private_animation? and user.role == 'user'
  end
end
