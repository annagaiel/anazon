class ProductsController < ApplicationController
  before_action :authenticate_admin!, except: [:index, :show]

  def index
    @categories = Category.all

    if params[:sort]
      @products = Product.order(params[:sort] => params[:sort_order])
    elsif params[:discount]
      @products = Product.where("price < ?", 8)
    elsif params[:category]
      @products = Category.find_by(name: params[:category]).products
    else
      @products = Product.all
    end
  end

  def show
    if params[:id] == "random"
      @product = Product.all.sample
    else
      @product = Product.find(params[:id])
    end
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find_by(id: params[:id])
  end

  def create
    @product = Product.create(name: params[:name], price: params[:price],
     description: params[:description], available: Product.in_stock, supplier_id: params[:supplier]["supplier_id"])

    if @product.valid?
      flash[:success] = "#{@roduct.name} was created!"
      redirect_to "/products/#{@product.id}"
    else
      render :new
    end
  end

  def update
    @product = Product.find_by(id: params[:id])
    @product.update_attributes(name: params[:name], price: params[:price],
     image: params[:image], description: params[:description], available: Product.in_stock)
    flash[:success] = "#{@product.name} was update!"
    redirect_to "/products/#{@product.id}"
  end

  def destroy
    @product = Product.find_by(id: params[:id])
    @product.destroy
    flash[:warning] = "#{@product.name} was deleted!"
    redirect_to root_path
  end

  def search
    search_term = params[:user_search]
    @products = Product.where("name LIKE ? OR description LIKE ?", "%#{search_term}%", "%#{search_term}%")
    render :index
  end
end
