# README

|Column|Type|Options|
|------|----|-------|

## usersテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|comment|text||
|icon|string||
|address|string|null: false|
|phone_number|integer|null: false, unique: true|
|mail|string|null: false|
|password|integer|null: false|
|good|string|null: false|
|normal|string|null: false|
|bad|string|null: false|

### Association

- has_many :payments
- has_many :comments
- has_many :likes
- has_many :items, through: :likes


## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|content|text|null: false|
|user_id|integer|null: false, foreign_key: true|

### Association

- belongs_to :user
- belongs_to :item


## itemsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|price|integer|null: false|
|description|text|null: false|
|status|string|null: false|
|ship_fee|string|null: false|
|ship|string|null: false|
|prefecture|string|null: false|
|date|string|null: false|
|size|string||
|user_id|integer|null: false, foreign_key: true|

### Association

- has_many :comments
- has_many :images
- has_many :likes
- belongs_to :brand
- has_many :items, through: :likes


## categorysテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|item_id|integer|null: false, foreign_key: true|
|brand_id|integer|null: false, foreign_key: true|

### Association

- has_many :items
- has_many :brands


## imagesテーブル

|Column|Type|Options|
|------|----|-------|
|item_id|integer|null: false, foreign_key: true|
|URL|string|null: false|

### Association

belongs_to :item


## paymentsテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|card_number|integer|null: false|
|pay_point|integer|null: false|

### Association

- belongs_to :user


## brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|item_id|integer|null: false, foreign_key: true|
|category_id|integer|null: false, foreign_key: true|

### Association

- has_many :items
- has_many :categorys


## likesテーブル

|Column|Type|Options|
|------|----|-------|
|item_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|

### Association

- belongs_to :user
- belongs_to :item







