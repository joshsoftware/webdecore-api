class CategoriesController < ApplicationController

	def index
		@count = Category.primary.count
		@outer = (@count-1)/4 + 1
		@categories = Category.primary
	end

	def new
		@primary_category = Category.new
		render "new1.html.erb" if params[:id] 
		
	end

	def create
		@primary_categories = Category.create(permit_params)
		redirect_to categories_path
	end

	def show
		@count = Category.find_by(id: params[:id]).secondary_categories.count
		@outer = (@count-1)/4 + 1
		@categories = Category.find_by(id: params[:id]).secondary_categories
	end

	private

		def permit_params
			params.require(:category).permit(:category_name, :category_description, :picture)
		end
	
end
