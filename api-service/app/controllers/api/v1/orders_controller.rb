class Api::V1::OrdersController < ApplicationController
  before_action :authorize_request, except: :index
  before_action :check_admin, except: [:index, :show]

  def index
    orders = Order.all
    render json: getOrdersJson(orders), status: 200
  end

  def create
    order = Order.new(
      status: order_params[:status],
      name_lastname: order_params[:name_lastname],
      address: order_params[:address],
      telephone: order_params[:telephone],
      date: order_params[:date]
    )
    if order.save
      create_product_order(order, order_params[:products])
      render json: order, status: 200
    else
      render json: {error: "Error creating order"}
    end
  end

  def create_product_order(order, products)
    products.each do |products_params|
      product = Product.find_by(id: products_params[:product_id])

      if product
        order.product_orders.create(
          product_id: products_params[:product_id],
          pieces: products_params[:pieces].to_i,
          price:  product.price.to_f * products_params[:pieces].to_i
        )
      else
        render json: { error: "Product not found with id #{products_params[:product_id]}" }, status: 404
        return
      end
    end
  end


  def show
    order = Order.find_by(id: params[:id])
    if order
      render json: getOrdersJson(order), status: 200
    else
      render json: {error: "Order Not Found"}
    end
  end

  def update
    order = Order.find_by(id: params[:id])

    if order
      if order.update(order_params)
        render json: order, status: 200
      else
        render json: { error: "Error updating order!" }, status: 422
      end
    else
      render json: { error: "Order not found." }, status: 404
    end
  end

  def update_status
    order = Order.find_by(id: params[:id])

    if order
      if order.update(status: params[:status])
        render json: order, status: 200
      else
        render json: { error: "Error updating order status!" }, status: 422
      end
    else
      render json: { error: "Order not found." }, status: 404
    end
  end

  def destroy
    order = Order.find_by(id: params[:id])

    if order
      order.destroy
      render json: { message: "Order successfully deleted." }, status: 200
    else
      render json: { error: "Order not found." }, status: 404
    end
  end

  private
    def order_params
      params.require(:order).permit([
        :status,
        :name_lastname,
        :address,
        :telephone,
        :date,
        products: [:product_id, :pieces]
      ])
    end

    def getOrdersJson(orders)
      orders.as_json(
        only: [:id, :status, :name_lastname, :address, :telephone, :date],
        include: {
          product_orders:{
            only: [:id, :pieces, :price],
            include: {
              product: {
                only: [:id, :name, :price]
              }
            }
          }
        }
      )
    end
end
