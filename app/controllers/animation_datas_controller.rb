class AnimationDatasController < ApplicationController
	def index
		@animations = AnimationData.all
		puts @animations
	end


	def show
		@count = AnimationData.find_by(categories_id: params[:id]).count
		@outer = (@count-1)/4 + 1
		@categories = Category.find_by(categories_id: params[:id])
	end
end
