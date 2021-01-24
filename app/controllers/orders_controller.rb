class OrdersController < ApplicationController
<<<<<<< HEAD
  
  def new
    @order = Order.new
  end  
  
  def create
    # 注文を保存
    @order = current_customer.orders.new(order_params)
    if @order.save
    # 注文商品に情報を保存
    cart_items = current_customer.cart_items #ユーザのカートの中身
    cart_items.each do |cart_item|
      tax_in_price = cart_item.product.price * 1.1
      @order_item = @order.order_items.new
      @order_item.order_id = @order.id
      @order_item.product_id = cart_item.product_id
      @order_item.amount = cart_item.amount
      @order_item.tax_in_price = tax_in_price.floor
      @order_item.save
    end  
    end
    current_customer.cart_items.destroy_all
    redirect_to  order_success_orders_path
  end  
    
  def order_confirm
    @cart_items = current_customer.cart_items
    @cart_item_price = cart_amount(@cart_items) #商品の合計
    @total_price = billing_amount(@cart_items) #請求金額
    @order = Order.new
    @payment_method = params[:order][:payment_method]
    shipping_attribute = params["shipping_attribute"] 
    #ご自身の住所 
    if shipping_attribute == "1"
      @zipcode = current_customer.zipcode
      @address = current_customer.address
      @name = current_customer.last_name + current_customer.first_name
    #登録済の住所
    elsif shipping_attribute == "2"
      shipping_information = ShippingInformation.find(params[:order][:shipping_information])      
      @zipcode = shipping_information.zipcode
      @address = shipping_information.address
      @name = shipping_information.name
    #新しいお届け先/保存する
    elsif shipping_attribute == "3"
      @zipcode = params[:order][:zipcode]
      @address = params[:order][:address]
      @name = params[:order][:name]
      shipping_information = ShippingInformation.create(
                                                        customer_id: current_customer.id,
                                                        zipcode: @zipcode,
                                                        address: @address,
                                                        name: @name
                                                        )
    end
  end
  
  def index
    @orders = Order.all
  end  
  
  private
  def order_params
    params.require(:order).permit(:zipcode, :address, :name, :payment_method, :sipping_attribute, :shipping_information, :total_price, :customer_id)
  end
  
  def order_item_params
    params.require(:order_item).permit(:order_id, :product_id, :amount, :tax_in_price)
  end
  
  #商品の合計（税なし）
  def cart_amount(cart_items)
    array = []
    cart_items.each do |cart_item|
      array << cart_item.product.price * cart_item.amount
    end
    array.sum
  end
  
  #請求金額(税込み・送料込み)
  def billing_amount(cart_items)
    array = []
    cart_items.each do |cart_item|
      array << cart_item.product.price * cart_item.amount
=======
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
>>>>>>> 87b7105f729fdd6ba2f80f690bfe0ff7cc40cb50
    end
    cart_amount = array.sum
    cart_amount_add_tax = cart_amount * 1.1
    cart_amount_add_tax += 800
    cart_amount_add_tax.floor
<<<<<<< HEAD
  end  
=======
  end
>>>>>>> 87b7105f729fdd6ba2f80f690bfe0ff7cc40cb50
end
