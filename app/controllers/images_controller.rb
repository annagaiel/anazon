class ImagesController < ApplicationController

  def new
  end

  def create
    @new_image = Image.new(url: params[:url])
    @new_image.save

    if @new_image.valid?
      flash[:success] = "Image was created!"
      redirect_to "/products/#{@new_image.product.id}"
    end
  end
end
