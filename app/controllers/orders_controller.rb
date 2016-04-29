class OrdersController < ApplicationController

  def create
    product = Product.find_by(id: params[:product_id])
    price = product.price * params[:quantity].to_i
    @order = Order.new(user_id: current_user.id,
                      product_id: product.id,
                      quantity: params[:quantity].to_i,
                      subtotal: price,
                      tax: price * 0.09,
                      total: price * 1.09
                      )
    @order.save
    flash[:success] = 'New order saved!'
    redirect_to "/orders/#{@order.id}"
  end

  def show
    @orders = current_user.orders
  end

  def index
    @orders = current_user.orders
    render 'show'
  end
end
