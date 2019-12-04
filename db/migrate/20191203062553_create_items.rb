class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :price
      t.text :description
      t.integer :status
      t.integer :ship_fee
      t.integer :ship
      t.integer :ship_area
      t.integer :date
      t.integer :size
      t.integer :user_id
      t.integer :buyer_id
      t.integer :brand_id
      t.timestamps
    end
  end
end