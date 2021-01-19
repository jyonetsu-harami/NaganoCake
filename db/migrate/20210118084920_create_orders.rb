class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id,     null: false
      t.integer :total_price,     null: false
      t.string :zipcode,          null: false
      t.text :address,            null: false
      t.string :name,             null: false
      t.integer :payment_method,  null: false, default: 0
      t.integer :status,          null: false, default: 0
      t.integer :postage,         null: false, default: 800
      t.timestamps
    end
  end
end
