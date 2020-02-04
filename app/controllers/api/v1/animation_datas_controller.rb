module Api
    module V1
        class AnimationDatasController < ApplicationController

            def index
              @animation = AnimationData.where(category_id: params[:category_id])
              pp @animation
              render json: {data: @animation}
            end
            

            def get_animation
              current_user = User.first
              location = params[:location]
              animation = User.animations.for(location)

              render json: animation.animation_json

            end
        end
    end
end