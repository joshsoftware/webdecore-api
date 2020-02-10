# frozen_string_literal: true

class UserAnimation < ApplicationRecord
  validates :start_date, :end_date, :location, presence: true
  belongs_to :user
  belongs_to :animation_data
end
