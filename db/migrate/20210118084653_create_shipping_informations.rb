class CreateShippingInformations < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_informations do |t|

      t.timestamps
    end
  end
end
