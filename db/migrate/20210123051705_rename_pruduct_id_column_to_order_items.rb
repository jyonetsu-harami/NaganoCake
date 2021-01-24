class RenamePruductIdColumnToOrderItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :order_items, :pruduct_id, :product_id
  end
end
