class ProductsController < ApplicationController
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
  end

  def edit
    @product = Product.find_by(id: params[:id])
  end

  def create
    @new_product = Product.new(name: params[:name], price: params[:price],
     description: params[:description], available: Product.in_stock, supplier_id: params[:supplier]["supplier_id"])
    @new_product.save

    if params[:image]
      new_image = Image.new(url: params[:image], product_id: @new_product.id)
      new_image.save
    end

    if @new_product.valid?
      flash[:success] = "#{@new_product.name} was created!"
      redirect_to "/products/#{@new_product.id}"
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
