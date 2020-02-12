class Role < ApplicationRecord
  validates :role_name, presence: true
  has_many :user
end
