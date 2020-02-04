module Api
    module V2
        class AnimationDatasController < ApplicationController

            def index
              @animation = AnimationData.where(category_id: params[:category_id])
              render json: {data: @animation}
            end
            
        end
    end
end