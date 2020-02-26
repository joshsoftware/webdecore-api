class Theme < ApplicationRecord
  validates :theme_name, :picture, :theme_json, presence: true
  mount_uploader :picture, PictureUploader
  belongs_to :user
end
