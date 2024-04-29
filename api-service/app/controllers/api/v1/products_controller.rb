class Api::V1::ProductsController < ApplicationController
  before_action :authorize_request, except: :index
  before_action :check_admin, except: [:index, :show]

  def index
    products = Product.all
    render json: getProductsJson(products), status: 200
  end

  def create
    product = Product.new(
      name: product_params[:name],
      description: product_params[:description],
      price: product_params[:price],
      category: Category.find_by(id: product_params[:category_id])
    )

    if product.save
      create_product_specifications(product, product_params[:specifications])
      render json: product, status: 200
    else
      render json: { error: "Error creating product" }
    end
  end

  def create_product_specifications(product, specifications)
    specifications.each do |specification_params|
      product.product_specifications.create(
        specification_id: specification_params[:specification_id],
        description: specification_params[:description]
      )
    end
  end


  def show
    product = Product.find_by(id: params[:id])
    if product
      render json: getProductsJson(product), status: 200
    else
      render json: {error: "Product Not Found"}
    end
  end

  def update
    product = Product.find_by(id: params[:id])

    if product
      if product.update(product_params)
        render json: product, status: 200
      else
        render json: { error: "Error updating product!" }, status: 422
      end
    else
      render json: { error: "Product not found." }, status: 404
    end
  end

  def update_price
    product = Product.find_by(id: params[:id])

    if product
      if product.update(price: params[:price])
        render json: product, status: 200
      else
        render json: { error: "Error updating product price!" }, status: 422
      end
    else
      render json: { error: "Product not found." }, status: 404
    end
  end

  def destroy
    product = Product.find_by(id: params[:id])

    if product
      product.destroy
      render json: { message: "Product successfully deleted." }, status: 200
    else
      render json: { error: "Product not found." }, status: 404
    end
  end

  private
  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :price,
      :category_id,
      specifications: [:specification_id, :description]
    )
  end

  def getProductsJson(products)
    products.as_json(
      only: [:id, :name, :description, :price],
      include: {
        category: {
          only: [:id, :name]
        },
        product_specifications:{
          only: [:description],
          include: {
            specification: {
              only: [:id, :name]
            }
          }
        }
      }
    )
  end
end
