create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
  t.bigint "user_id", null: false
  t.string "address_family_name_kanji", null: false
  t.string "address_family_name_kana", null: false
  t.string "address_first_name_kanji", null: false
  t.string "address_first_name_kana", null: false
  t.string "address_number", null: false
  t.integer "address_prefecture", default: 0, null: false
  t.string "address_name", null: false
  t.string "address_block", null: false
  t.string "address_building"
  t.integer "address_phone_number"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
  t.index ["user_id"], name: "index_addresses_on_user_id"
end

create_table "cards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
  t.bigint "user_id", null: false
  t.string "customer_id", null: false
  t.string "card_id", null: false
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
  t.index ["user_id"], name: "index_cards_on_user_id"
end

create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
  t.string "name"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
  t.string "ancestry"
  t.index ["ancestry"], name: "index_categories_on_ancestry"
end

create_table "exhibits", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
  t.string "name"
  t.integer "price"
  t.text "description"
  t.string "status"
  t.integer "ship"
  t.string "ship_fee"
  t.string "prefecture"
  t.integer "size"
  t.integer "category_id", null: false
  t.integer "user_id", null: false
  t.integer "buyer_id"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
end

create_table "images", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
  t.integer "exhibit_id", null: false
  t.string "image", null: false
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
end

create_table "sns_credentials", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
  t.string "provider"
  t.string "uid"
  t.bigint "user_id"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
  t.index ["user_id"], name: "index_sns_credentials_on_user_id"
end

create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
  t.string "nickname", null: false
  t.string "email", default: "", null: false
  t.string "icon"
  t.text "comment"
  t.string "family_name_kanji", null: false
  t.string "family_name_kana", null: false
  t.string "first_name_kanji", null: false
  t.string "first_name_kana", null: false
  t.integer "year", null: false
  t.integer "month", null: false
  t.integer "day", null: false
  t.integer "phone_number", null: false
  t.string "encrypted_password", default: "", null: false
  t.string "reset_password_token"
  t.datetime "reset_password_sent_at"
  t.datetime "remember_created_at"
  t.datetime "created_at", null: false
  t.datetime "updated_at", null: false
  t.index ["email"], name: "index_users_on_email", unique: true
  t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
end

add_foreign_key "addresses", "users"
add_foreign_key "cards", "users"
add_foreign_key "sns_credentials", "users"
end