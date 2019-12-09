class CreateExhibits < ActiveRecord::Migration[5.2]
  def change
    create_table :exhibits do |t|
      t.string   :name 
      t.integer  :price
      t.text     :description
      t.string  :status
      t.string  :ship
      t.string  :ship_fee 
      t.string  :prefecture
      t.integer  :size
      t.integer   :category_id , null:false, foreign_key: true 
      t.integer  :user_id, null:false, foreign_key: true 
      t.integer  :buyer_id
      t.string :date
      t.timestamps
    end
  end
end

