class OrdersController < ApplicationController

  def create
    product = Product.find_by(id: params[:product_id])
    quantity = params[:quantity].to_i
    total_tax = product.tax * quantity
    subtotal = product.price * quantity
    total = total_tax + subtotal

    @order = Order.new(user_id: current_user.id,
                      product_id: product.id,
                      quantity: quantity,
                      subtotal: subtotal,
                      tax: total_tax,
                      total: total
                      )
    @order.save
    flash[:success] = 'New order saved!'
    redirect_to "/orders/#{@order.id}"
  end

  def show
    @orders = current_user.orders.find_by(id: params[:id])
  end

  def index
    @orders = current_user.orders
    render 'show'
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to "/orders/#{@order.id}"
  end

  def update
    order = Order.find_by(id: params[:id])
    total_tax = 0
    total_subtotal = 0
    order.carted_products.each do |carted_product|
      total_tax = carted_product.product.tax * carted_product.quantity
      total_subtotal += carted_product.product.price * carted_product.quantity
    end
    total = total_tax + total_subtotal
    order.update(completed: true, tax: total_tax, subtotal: total_subtotal, total: total)
    flash[:success] = "Order was updated!"
    redirect_to "/orders/#{order.id}"
  end
end
