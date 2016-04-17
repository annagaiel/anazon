class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
  end

  def edit
    @product = Product.find_by(id: params[:id])
  end

  def create
    @new_product = Product.new(name: params[:name], price: params[:price], image: params[:image], description: params[:description])
    @new_product.save

    if @new_product.valid?
      redirect_to root_path
    end
  end

  def update
    @product = Product.find_by(id: params[:id])
    @product.update_attributes(name: params[:name], price: params[:price], image: params[:image], description: params[:description])
    redirect_to products_path(@product)
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    @product.destroy

    redirect_to root_path
  end

end
