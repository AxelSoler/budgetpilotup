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

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to @category, notice: 'Category updated successfully.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path, notice: 'Category deleted successfully.'
  end

	private

	def category_params
		params.require(:category).permit(:name, :description)
	end
end
