class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :productid
      t.string :category
      t.string :product_name
      t.decimal :price, precision: 12, scale: 3

      t.timestamps null: false
    end
  end
end
