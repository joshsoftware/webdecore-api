class Role < ApplicationRecord
  validates :role_name, presence: true
end
