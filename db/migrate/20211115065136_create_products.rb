class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title
      t.string :size
      t.string :colour
      t.string :location
      t.string :condition
      t.string :brand
      t.decimal :price, precision: 8, scale: 2
      t.text :description
      t.boolean :available, default: true
      
      t.timestamps
    end
  end
end
