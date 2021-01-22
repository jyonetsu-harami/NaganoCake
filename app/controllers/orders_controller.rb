class OrdersController < ApplicationController
  
  def new
    @order = Order.new
    # @shipping_info = current_customer.shipping_informations
  end  
  
  def create
    @order = Order.new(order_params)
    @shipping_attribute = params["shipping_attribute"]
    #ご自身の住所 
    if @shipping_attribute == "1"
      @order.zipcode = current_customer.zipcode
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    #登録済の住所
    elsif @shipping_attribute == "2"
      # @shipping_info = params[:customer_id]
      # @shipping_info = ShippingInformation.new(shipping_info_params)
      # @shipping_info.zipcode = 
      # @shipping_info.address =
      # @shipping_info.name = 
    #新しいお届け先
    elsif @shippings_attribute == "3"
      # @new_address = Order.new(order_params)
      # @new_address.zipcode = params[:zipcode]
      # @new_address.address = params[:address]
      # @new_address.name = params[:name]
    end
    render :order_confirm
  end
  
  def order_confirm
  end
  
  def index
    @orders = Order.all
  end  
  
  private
  def order_params
    params.require(:order).permit(:zipcode, :address, :name, :payment_method, :sipping_attribute)
  end
  
  # def shipping_info_params
  #   params.require(:shipping_information).permit(:zipcode, :address, :name)
  # end  
end
