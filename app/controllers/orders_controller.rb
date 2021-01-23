class OrdersController < ApplicationController
  
  def new
    @order = Order.new
  end  
  
  def create
    @order = Order.new
    # @order.payment_method = 
    shipping_attribute = params["shipping_attribute"] 
    #ご自身の住所 
    if shipping_attribute == "1"
      @order.zipcode = current_customer.zipcode
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    #登録済の住所
    elsif shipping_attribute == "2"
      shipping_information = ShippingInformation.find(params[:order][:shipping_information])      
      @order.zipcode = shipping_information.zipcode
      @order.address = shipping_information.address
      @order.name = shipping_information.name
    #新しいお届け先
    elsif shipping_attribute == "3"
      @order.zipcode = params[:order][:zipcode]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
    render :order_confirm
  end
  
  def order_confirm
    @order = Order.new(order_params)
    if @order.save
      redirect_to order_success_orde_path
    end  
  end
  
  def index
    @orders = Order.all
  end  
  
  private
  def order_params
    params.require(:order).permit(:zipcode, :address, :name, :payment_method, :sipping_attribute, :shipping_information)
  end
end
