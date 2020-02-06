module Api
  module V1
    class AnimationDatasController < ApplicationController
      skip_before_action :authenticate_user!
      def index

        @animation_record = UserAnimation.find_by("user_id = ? AND location = ? AND start_date <= ? 
        AND end_date >= ?", params['user_id'], params['location'], Date.today, Date.today)
        if (@animation_record)
          @animation = AnimationData.find(@animation_record.animation_data_id).animation_json
          render json: @animation.as_json
        else
          render json: {}
        end
      end
    end
  end
end