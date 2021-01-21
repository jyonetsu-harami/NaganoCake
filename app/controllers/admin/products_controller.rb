class Admin::ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    @genres = Genre.all
  end

  def create
    @product = Prpduct.new(product_params)
    @product.save
    redirect_to admin_product_path()
  end

  def show
  end

  def edit
  end

  def update
  end

  def product_params
    params.require(:product).permit(:image, :name, :description,
    :genre_id, :price, :sales_status)
  end

end
