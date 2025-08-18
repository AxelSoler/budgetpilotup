class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
    @category.user = Current.user

		if @category.save
			redirect_to @category, notice: 'Category created successfully.'
		else
			render :new, status: :unprocessable_entity
		end
	end

	private

	def category_params
		params.require(:category).permit(:name, :description)
	end
end
