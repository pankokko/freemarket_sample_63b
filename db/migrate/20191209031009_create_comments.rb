class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|

      t.timestamps
      t.text :comment
      t.integer :exhibit_id, foreign_key: true
      t.integer :user_id, foreign_key: true
    end
  end
end
