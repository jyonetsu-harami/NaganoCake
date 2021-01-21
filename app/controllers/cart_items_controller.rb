class CartItemsController < ApplicationController
  before_action :authenticate_customer!, except: [:create]
  
  def create
    if customer_signed_in?
      cart_item = CartItem.find_by(customer_id: current_customer.id, product_id: 1)
      if cart_item.nil?
        cart_item = CartItem.new(cart_item_params)
        cart_item.customer_id = current_customer.id
        if cart_item.save
          redirect_to cart_items_path
        else
          flash[:info] = "数量を選択してください"
          redirect_back fallback_location: root_path
        end
      else
        cart_item = CartItem.update(cart_item_params)
        redirect_to cart_items_path
      end
    else
      flash[:info] = "カートに商品を追加するには、会員登録とログインが必要です"
      redirect_back fallback_location: root_path
    end
  end
  
  def index
    @cart_items = current_customer.cart_items
  end
  
  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_back fallback_location: root_path
  end
  
  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    redirect_back fallback_location: root_path
  end
  
  def destroy_all
    cart_items = current_customer.cart_items
    cart_items.destroy_all
    redirect_back fallback_location: root_path
  end
  
  private
  
  def cart_item_params
    params.require(:cart_item).permit(:amount, :product_id)
  end
end
