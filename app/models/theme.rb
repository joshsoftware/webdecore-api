class Theme < ApplicationRecord
  belongs_to :user
  has_many :assets
end
