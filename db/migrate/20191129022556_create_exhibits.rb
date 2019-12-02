class CreateExhibits < ActiveRecord::Migration[5.2]
  def change
    create_table :exhibits do |t|

      t.timestamps
      t.string   :name
      t.integer  :price
      t.text     :description
      t.string  :status
      t.integer  :ship
      t.string  :ship_fee
      t.string  :prefecture
      t.integer  :size




    end
  end
end
