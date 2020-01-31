class UserAnimation < ApplicationRecord
	belongs_to	:user
	belongs_to :animation_data
end
