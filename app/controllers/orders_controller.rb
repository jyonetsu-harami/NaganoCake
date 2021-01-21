class OrdersController < ApplicationController
  
  def new
    @order = Order.new
  end  
  
  def create
    address_attribute = params[:sipping_address]      
    @order = Order.new
    if address_attribute == 1
      @order.zipcode = current_customer.zipcode
      @order.address = current_customer.address
      @order.name = current_customer.last_name +current_customer.first_name
    elsif address_attribute == 2
      
    elsif address_attribute == 3
      
    end
      
    end
    render :order_confirm
  end
  
  def order_confirm
    @order = Order.new(order_params)
    @shipping_address = params([:shipping_address])
  end
  
  def index
    @orders = Order.all
  end  
  
  private
  def order_params
    params.require(:order).permit(:zipcode, :address, :name, :payment_method, :shipping_address)
  end
end
