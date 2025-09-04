class CategoriesController < ApplicationController
  before_action :set_category, only: %i[update destroy]

  def index
    @categories = Current.user.categories
  end

  def new
    @category = Category.new
  end

  def create
    @category = Current.user.categories.new(category_params)

    if @category.save
      redirect_to categories_url, notice: "Category created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      redirect_to categories_url, notice: "Category updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.destroy
      redirect_to categories_path, notice: "Category deleted successfully."
    else
      redirect_to categories_path, alert: @category.errors.full_messages.to_sentence
    end
  end

  private

  def set_category
    @category = Current.user.categories.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
