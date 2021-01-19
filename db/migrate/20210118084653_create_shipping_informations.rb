class CreateShippingInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_informations do |t|
      t.integer :customer_id, null: false
      t.string :zipcode,      null: false
      t.string :address,      null: false
      t.string :name,         null: false
      t.timestamps
    end
  end
end
