class ProductsController < ApplicationController
  
  def show
    @product = Product.find(params[:id])
    @cart_item = CartItem.new
  end
  
  def index
    @products = Product.page(params[:page]).all.per(6)
  end
end
