class OrdersController < ApplicationController

  def new
    @order = Order.new
    @current_customer = current_customer
  end

  def create
    @order = Order.new(order_params)
     @order.save
      @cart_items = current_customer.cart_items.all
        @cart_items.each do |cart_item|
          @order_items = @order.order_items.new
          @order_items.order_id = @order.id
          @order_items.product_id = cart_item.product_id
          @order_items.amount = cart_item.amount
          @order_items.tax_in_price = cart_item.product.price*1.1
          @order_items.save
        end
    current_customer.cart_items.destroy_all
    redirect_to order_success_orders_path
  end

  def order_confirm
    @order = Order.new
    @cart_items = current_customer.cart_items
    @cart_items_total_price = cart_items_total_price
    @total_price = total_price
    @payment_method = params[:order][:payment_method]

    if params[:order][:shipping_address] == '1'
      @zipcode = current_customer.zipcode
      @address = current_customer.address
      @name = current_customer.last_name + current_customer.first_name
      render :order_confirm
    #登録済の住所
    elsif params[:order][:shipping_address] == '2'
      shipping_infomation = ShippingInformation.find(params[:order][:shipping_information])
      @zipcode = shipping_infomation.zipcode
      @address = shipping_infomation.address
      @name = shipping_infomation.name
       render :order_confirm
    #新しいお届け先
    elsif params[:order][:shipping_address] == '3'
      @zipcode = params[:order][:zipcode]
      @address = params[:order][:address]
      @name = params[:order][:name]
      shipping_infomation = ShippingInformation.create(
        customer_id: current_customer.id,
        zipcode: @zipcode,
        address: @address,
        name: @name
        )
      render :order_confirm
    else
    render :"products/index"
    end
  end


  def order_success
  end

  def index
    @orders = Order.all
  end

  def cart_items_total_price
    cart_items = current_customer.cart_items
    array = []
    cart_items.each do |cart_item|
      array << cart_item.product.price*cart_item.amount
    end
    array.sum
  end

  def total_price
    postage = @order.postage
    total_price = cart_items_total_price*1.1 + postage
  end
end

  private
  def order_params
    params.require(:order).permit(:zipcode, :address, :name, :payment_method,
                                  :shipping_address, :customer_id, :total_price
                                  )
  end

  def order_item_params
    params.require(:order_item).permit(:order_id, :product_id, :amount, :tax_in_price)
  end