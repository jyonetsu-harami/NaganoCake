class OrdersController < ApplicationController
  
  def new
    @order = Order.new
    # customer = @order.customer
    # @info = customer.shipping_informations
  end  
  
  def create
  end
  
  private
  def order_params
    params.require(:order).permit(:zipcode, :address, :name, :payment_method)
  end
end
