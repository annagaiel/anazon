class ImagesController < ApplicationController

  def new
  end

  def create
    debugger
    @product = Product.find(params[:product_id])
    @new_image = Image.new(url: params[:url], product_id: "#{@product.id}")
    @new_image.save
    if @new_image.valid?
      flash[:success] = "Image was created!"
      redirect_to "/products/#{@new_image.product_id}"
    else
      flash[:error] = "Error! Image was not created!"
      render "new"
    end
  end
end
