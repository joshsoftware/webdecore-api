module Api
  module V1
    class AnimationDatasController < ApplicationController
      skip_before_action :authenticate_user!
      def index

        @animation_record = UserAnimation.
          where("start_date <= :today_date AND end_date >= :today_date", today_date: Date.today).
          where(user_id: params['user_id'], location: params['location']).first
        if (@animation_record)
          @animation = AnimationData.find_by(id: @animation_record.animation_data_id).animation_json
          render json: @animation.as_json
        else
          render json: {}
        end

      end
    end
  end
end
