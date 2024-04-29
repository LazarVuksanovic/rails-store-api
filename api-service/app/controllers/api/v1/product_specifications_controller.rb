class Api::V1::ProductSpecificationsController < ApplicationController

  def index
    product_specification = ProductSpecifications.all
    render json: product_specification, status: 200
  end

  def create
    product_specification = ProductSpecifications.new(
      description: product_specification_params[:description],
    )
    if product_specification.save
      render json: product_specification, status: 200
    else
      render json: {error: "Error creating product specification"}
    end
  end

  def show
    product_specification = ProductSpecifications.find_by(id: params[:id])
    if product_specification
      render json: product_specification, status: 200
    else
      render json: {error: "Product Specification Not Found"}
    end
  end

  private
    def product_specification_params
      params.require(:specification).permit([
        description:,
      ])
    end
end
