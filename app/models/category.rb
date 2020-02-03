# frozen_string_literal: true

class Category < ApplicationRecord
  mount_uploader :picture, PictureUploader
  has_many :animation_data
  has_many :secondary_categories, class_name: 'Category', foreign_key: 'primarycategory_id'
  belongs_to :primarycategory, class_name: 'Category', optional: true

  scope :primary, -> { where(primarycategory_id: nil) }
end
