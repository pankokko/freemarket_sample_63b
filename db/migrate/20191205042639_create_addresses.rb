class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table   :addresses do |t|
      t.references :user, foreign_key: true, null: false
      t.string     :address_family_name_kanji, null: false
      t.string     :address_family_name_kana, null: false
      t.string     :address_first_name_kanji, null: false
      t.string     :address_first_name_kana, null: false
      t.string     :address_number, null: false
      t.string     :address_prefecture, null: false
      t.string     :address_name, null: false
      t.string     :address_block, null: false
      t.string     :address_building
      t.string     :address_phone_number
      t.timestamps
    end
  end
end
