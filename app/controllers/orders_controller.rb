class OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @order = Order.new
  end
  
  def create
    order = Order.new(order_params)
    if order.save
      cart_items = current_customer.cart_items
      cart_items.each do |cart_item|
        tax_in_price = cart_item.product.price * 1.1
        OrderItem.create(
          order_id: order.id,
          product_id: cart_item.product_id,
          amount: cart_item.amount,
          tax_in_price: tax_in_price.floor
          )
      end
      current_customer.cart_items.destroy_all
      redirect_to  order_success_orders_path
    end
  end
  
  def order_confirm
    @order = Order.new
    @cart_items = current_customer.cart_items
    @total_price = billing_amount(@cart_items)
    @payment_method = params[:order][:payment_method]
    if params[:order][:shipping_method] == "1"
      @zipcode = current_customer.zipcode
      @address = current_customer.address
      @name = current_customer.full_name
    elsif params[:order][:shipping_method] == "2"
      shipping_infomation = ShippingInformation.find(params[:order][:shipping_information])
      @zipcode = shipping_infomation.zipcode
      @address = shipping_infomation.address
      @name = shipping_infomation.name
    elsif params[:order][:shipping_method] == "3"
      @zipcode = params[:order][:zipcode]
      @address = params[:order][:address]
      @name = params[:order][:name]
      shipping_infomation = ShippingInformation.create(
        customer_id: current_customer.id,
        zipcode: @zipcode,
        address: @address,
        name: @name
        )
    end
  end
  
  def order_success
  end
  
  def index
    @orders = current_customer.orders
  end
  
  private
  def order_params
    params.require(:order).permit(:customer_id, :zipcode, :address, :name, :payment_method, :shipping_method, :total_price )
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
