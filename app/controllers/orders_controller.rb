class OrdersController < ApplicationController
  
  def new
    @order = Order.new
  end  
  
  def create
    @order = Order.new
    @cart_items = current_customer.cart_items
    # @total_price　ここで確定させて以下の条件分岐内で使用する。確認ページのビューでも使用する
    if params[:order][:shipping_method] == "1"
      # ここからorderインスタンスに情報を入れていく
      @order.zipcode = current_customer.zipcode
      @order.address = current_customer.address
      # @order.name = フルネーム　よこさんがシェアしてくれた記事の方法で行ける
      .
      .
      .
    elsif params[:order][:shipping_method] == "2"
      @shipping_address = "current_customer.sipping_informations、どれかの住所"#条件分岐を試したときの記述
    elsif params[:order][:shipping_method] == "3"
      @shipping_address = "新規配送先住所"#条件分岐を試したときの記述
    end
    render :order_confirm
  end
  
  def order_confirm
    # renderでcreateアクションのインスタンス変数を引き継がせて表示させる
  end
  
  def index
    @orders = Order.all
  end  
  
  private
  def order_params
    params.require(:order).permit(:zipcode, :address, :name, :payment_method, :shipping_method)
  end
end
