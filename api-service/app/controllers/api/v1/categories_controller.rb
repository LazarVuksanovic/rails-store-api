class Api::V1::CategoriesController < ApplicationController
  before_action :authorize_request, except: :index
  before_action :check_admin, except: [:index, :show]

  def index
    categories = Category.all
    render json: categories, status: 200
  end

  def create
    category = Category.new(
      name: category_params[:name],
    )
    if category.save
      render json: category, status: 200
    else
      render json: {error: "Error creating category"}
    end
  end

  def show
    category = Category.find_by(id: params[:id])
    if category
      render json: category, status: 200
    else
      render json: {error: "Category Not Found"}
    end
  end

  def update
    category = Category.find_by(id: params[:id])

    if category
      if category.update(category_params)
        render json: category, status: 200
      else
        render json: { error: "Error updating category!" }, status: 422
      end
    else
      render json: { error: "Category not found." }, status: 404
    end
  end

  def destroy
    category = Category.find_by(id: params[:id])

    if category
      category.destroy
      render json: { message: "Category successfully deleted." }, status: 200
    else
      render json: { error: "Category not found." }, status: 404
    end
  end

  private
    def category_params
      params.require(:category).permit(:name)
    end
end
