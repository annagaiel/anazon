class CartedProductsController < ApplicationController

  def index
    @carted_products = Order.where(user_id: current_user.id).find_by(completed: false).carted_products
    @order = Order.where(user_id: current_user.id).find_by(completed: false)
    redirect_to "/products" if @carted_products.nil?
  end

  def create
    product = Product.find_by(id: params[:product_id])
    quantity = params[:quantity].to_i
    total_tax = product.tax * quantity
    subtotal = product.price * quantity
    total = total_tax + subtotal
    if !Order.find_by(user_id: current_user.id, completed: false)
      order = Order.new(user_id: current_user.id,
                        subtotal: subtotal,
                        tax: total_tax,
                        total: total
                        )
      order.save
      carted_products = CartedProduct.new(product_id: product.id,
                                          order_id: order.id,
                                          quantity: quantity
                                          )
      carted_products.save
      p "created new order"
    else
       order = Order.find_by(user_id: current_user.id)
       carted_products = CartedProduct.new(product_id: product.id,
                                           order_id: order.id,
                                           quantity: quantity
                                           )
       carted_products.save
       flash[:success] = 'Item added to Cart!'
       p "updated old order"
    end
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
    @carted_products.update(quantity: )
    flash[:warning] = 'Item quantity updated from Cart!'
    redirect_to "/carted_products"
  end
end
