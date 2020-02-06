# frozen_string_literal: true

class UserAnimationsController < ApplicationController
  def index
    @animations = UserAnimation.all
  end
end
