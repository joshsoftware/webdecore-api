# frozen_string_literal: true

class AnimationData < ApplicationRecord
  validates :animation_name, :animation_price, :picture, :animation_json, presence: true
  mount_uploader :picture, PictureUploader
  belongs_to :category
  has_many :user_animations
  has_many :users, through: :user_animations
end
