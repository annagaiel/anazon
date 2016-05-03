class CartedProductsController < ApplicationController

  def index
    @carted_products = Order.where(user_id: current_user.id).find_by(completed: false).carted_products
  end

  def create
    product = Product.find_by(id: params[:product_id])
    quantity = params[:quantity].to_i
    total_tax = product.tax * quantity
    subtotal = product.price * quantity
    total = total_tax + subtotal
    if Order.find_by(user_id: current_user.id).nil?
      order = Order.new(user_id: current_user.id,
                        subtotal: subtotal,
                        tax: total_tax,
                        total: total
                        )
      order.save
    else
       order = Order.find_by(user_id: current_user.id)
       carted_products = CartedProduct.new(product_id: product.id,
                                           order_id: order.id,
                                           quantity: quantity
                                           )
       carted_products.save
       flash[:success] = 'Item added to Cart!'
    end
    redirect_to "/carted_products"
  end
end
