class OrdersController < ApplicationController
  
  def new
    @order = Order.new
  end
  
  def create
    if params[:order][:fixed] == "1"
      order = Order.new(order_params)
      order.save
      redirect_to order_success_order_path(@order.id)
    else
      @cart_items = current_customer.cart_items
      @total_price = billing_amount(@cart_items)
      @payment_method = params[:order][:payment_method]
      @fixed = "fixed"
      if params[:order][:shipping_method] == "1"
        @shipping_address = current_customer.merge_zipcode_to_address
        @name = current_customer.full_name
        @zipcode = current_customer.zipcode
      elsif params[:order][:shipping_method] == "2"
        shipping_infomation = ShippingInformation.find(params[:order][:shipping_information])
        @shipping_address = shipping_infomation.merge_zipcode_to_address
        @name = shipping_infomation.name
        @order = Order.new(
          total_price: @total_price,
          zipcode: shipping_infomation.zipcode,
          address: shipping_infomation.address,
          name: @name,
          payment_method: @payment_method
          )
      elsif params[:order][:shipping_method] == "3"
        @shipping_address = "新規配送先住所"#条件分岐を試したときの記述
      end
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
    params.require(:order).permit(:zipcode, :address, :name, :payment_method, :shipping_method, :fixed)
  end
  
  def billing_amount(cart_items)
    array = []
    cart_items.each do |cart_item|
      array << cart_item.product.price*cart_item.amount
    end
    cart_amount = array.sum
    cart_amount_add_tax = cart_amount * 1.1
    cart_amount_add_tax += 800
    cart_amount_add_tax.floor
  end
end
