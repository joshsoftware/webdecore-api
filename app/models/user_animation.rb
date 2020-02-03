# frozen_string_literal: true

class UserAnimation < ApplicationRecord
  belongs_to :user
  belongs_to :animation_data
end
