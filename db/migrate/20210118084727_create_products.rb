class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.integer :genre_id,      null: false
      t.string :image_id,       null: false
      t.string :name,           null: false
      t.text :description,      null: false
      t.integer :price,         null: false
      t.boolean :sales_status,  null: false, default: true
      t.timestamps
    end
  end
end
