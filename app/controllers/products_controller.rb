class ProductsController < ApplicationController
  
  def show
    @product = Product.find(params[:id])
    @cart_item = CartItem.new
  end
  
  def index
    @products = Product.all
  end
end
