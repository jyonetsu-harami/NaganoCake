class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :order_id,      null: false
      t.integer :pruduct_id,    null: false
      t.integer :amount,        null: false
      t.integer :making_status, null: false, default: 0
      t.integer :tax_in_price,  null: false
      t.timestamps
    end
  end
end
