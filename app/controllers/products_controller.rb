class ProductsController < ApplicationController
  
  def show
    @product = Product.find(params[:id])
    @cart_item = CartItem.new
  end
  
  def index
    @product = Product.page(params[:page]).all.per(6)
    @products = Product.all
  end
end
