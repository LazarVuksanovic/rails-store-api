class Api::V1::ProductOrdersController < ApplicationController

  def index
    product_order = ProductOrders.all
    render json: product_order, status: 200
  end

  def create
    product_order = ProductOrders.new(
      pieces: product_order_params[:pieces],
      price: product_order_params[:price],
    )
    if product_order.save
      render json: product_order, status: 200
    else
      render json: {error: "Error creating product order"}
    end
  end

  def show
    product_order = ProductOrders.find_by(id: params[:id])
    if product_order
      render json: product_order, status: 200
    else
      render json: {error: "Product Order Not Found"}
    end
  end

  private
    def product_order_params
      params.require(:order).permit([
        pieces:,
        price:
      ])
    end
end
