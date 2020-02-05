module Api
    module V1
        class AnimationDatasController < ApplicationController
            skip_before_action :authenticate_user!
            def index
            #   @animation = AnimationData.where(category_id: params[:category_id])
            #   render json: {data: @animation}   
            # @user = User.first
            puts params
            @user_id = params['user_id']
            @location = params['location']
            @animation_record = UserAnimation.where(user_id: @user_id, location: @location)[0]
            @animation_id = @animation_record.animation_data_id
            @animation = AnimationData.find(@animation_id).animation_json
            render json: @animation.as_json

            end
        end
    end
end



























    
        
  
        
