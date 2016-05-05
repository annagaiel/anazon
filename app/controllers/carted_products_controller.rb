class CartedProductsController < ApplicationController
  before_action :authenticate_user!

  def index
    binding.pry
    @carted_products = Order.where(user_id: current_user.id).find_by(completed: false).carted_products
    @order = Order.where(user_id: current_user.id).find_by(completed: false)
    redirect_to "/products" if @carted_products.nil?
  end

  def create
    order = (current_user.orders.find_by(completed: false) || Order.create(completed: false, user_id: current_user.id))
    carted_product = CartedProduct.new(product_id: params[:product_id], quantity: params[:quantity], order_id: order.id)
    carted_product.save
    redirect_to "/carted_products"
  end

  def destroy
    @carted_products = CartedProduct.find_by(id: params[:id])
    @carted_products.destroy
    flash[:warning] = 'Item deleted from Cart!'
    redirect_to "/carted_products"
  end

  def update
    @carted_products = CartedProduct.find_by(id: params[:id])
    flash[:warning] = 'Item quantity updated from Cart!'
    redirect_to "/carted_products"
  end
end
