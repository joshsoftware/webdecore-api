# frozen_string_literal: true

class AnimationData < ApplicationRecord
  belongs_to :secondary_category
  has_many :user_animations
  has_many :users, through: :user_animations
end
