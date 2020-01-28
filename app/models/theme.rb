# frozen_string_literal: true

class Theme < ApplicationRecord
  validates :theme_name, presence: true
  belongs_to :user
  has_many :assets
end
