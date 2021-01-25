class Admin::OrderItemsController < ApplicationController
  def update
    order_item = OrderItem.find(params[:id])
    order = Order.find(order_item.order_id)
    if order_item.update(order_item_params) && params[:order_item][:making_status] == "制作中"
    # ステータスのupdateが成功、なおかつそのステータスが"制作中"だった場合order.statusを"制作中"に変更
      order.update(status: "制作中")
    elsif order_item.update(order_item_params) && params[:order_item][:making_status] == "制作完了"
      if order.order_items.count == order.order_items.where(making_status: "制作完了").count
      # orderに紐付いたorder_itemのレコードの件数と、orderに紐付いたmaking_statusが"制作完了"のレコードの件数が同じだった場合、order.statusを"発送準備中"に変更
        order.update(status: "発送準備中")
      end
    end
    redirect_back fallback_location: root_path
  end
  
  private
  
  def order_item_params
    params.require(:order_item).permit(:making_status)
  end
end
