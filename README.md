# usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, length: { maximum: 20 }|
|email|string|null: false, unique: true|
|password|string|null: false|
|introduction|text||
|birthday|date||
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_kana|string|null: false|
|first_name_kana|string|null: false|
|sales_proceed|integer|null: false|
|point|integer|null: false|
## Association
- has_many :items, through: :comments
- has_many :deals, through: :deal_has_users
- has_many :delivery_addresses
- has_one :user_address
- has_one :avatar

# user_addressesテーブル
|Column|Type|Options|
|------|----|-------|
|zip_code|string|length: { maximum: 8 }|
|prefecture|string||
|city|string||
|street_number|string||
|building|string||
|user_id|references|null: false, foreign_key: true|
## Association
- belongs_to :user

# delivery_addressesテーブル
|Column|Type|Options|
|------|----|-------|
|zip_code|string|null: false, length: { maximum: 8 }|
|prefecture|string|null: false|
|city|string|null: false|
|street_number|string|null: false|
|building|string||
|telephone|string||
|user_id|references|null: false, foreign_key: true|
## Association
- belongs_to :user

# avatarsテーブル
|Column|Type|Options|
|------|----|-------|
|image|string||
|user:id|references|null: false, foreign_key: true|
## Association
- belongs_to :user

# itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, length: { maximum: 40 }|
|price|integer|null: false|
|description|text|null: fals, length: { maximum: 1000 }|
|sale_status|integer|null: false|
|buy_status|integer|null: false|
|user_id|references|null: false, foreign_key: true|
## Association
- belongs_to :user, through: :comments
- has_many :item_images
- has_one :shipping_origin
- has_one :category
- has_one :item_detail

# item_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|url|string|null: false|
|item_id|references|null: false, foreign_key: true|
## Association
- belongs_to :item

# shipping_originsテーブル
|Column|Type|Options|
|------|----|-------|
|origin_region|integer|null: false|
|shipping_day|integer|null: false|
|shipping_method|integer|null: false|
|shipping_burden|boolean|null: false|
|item_id|references|null: false, foreign_key: true|
## Association
- belongs_to :item

# commentsテーブル
|Column|Type|Options|
|------|----|-------|
|content|text||
|like|integer||
|user_id|references|null: false, foreign_key: true|
|item_id|references|null: false, foreign_key: true|
## Association
- belongs_to :user
- belongs_to :item

# dealsテーブル
|Column|Type|Options|
|------|----|-------|
|valuation|||
|user_id|references|null: false, foreign_key: true|
## Association
- belongs_to :user, through: :deal_has_users

# deal_has_usersテーブル
|Column|Type|Options|
|------|----|-------|
|deal_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|
## Association
- belongs_to :deal
- belongs_to :user

# item_detailテーブル
|Column|Type|Options|
|------|----|-------|
|size|integer|null: false|
|brand|string||
|condition|integer|null: false|
|item_id|references|null: false, foreign_key: true|
## Association
- belongs_to :item

# categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|parent_id|string|null: false|
|item_id|string|null: false|
## Association
- belongs_to :item

# newsテーブル
|Column|Type|Options|
|------|----|-------|
|title|sting|null: false|
|content|string|null: false|
## Association
- nothing
