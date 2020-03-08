module Api
  module V1
    class AnimationDatasController < ApplicationController
      skip_before_action :authenticate_user!
      def index
        user = User.where(uuid: params['uuid']).first
        return render json: {} unless user.present?
        @animation_record = UserAnimation.
          where('start_date <= :today_date AND end_date >= :today_date', today_date: Date.today).
          where(user_id: user, location: params['location']).first
        if @animation_record
          @animation = AnimationData.find(@animation_record.animation_data_id).animation_json
          render json: { animation: @animation.as_json, frequency: @animation_record.frequency }
        else
          render json: {}
        end
      end
    end
  end
end
