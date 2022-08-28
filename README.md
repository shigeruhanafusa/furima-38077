# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## usersテーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| name                | string     | null: false                    |
| encrypted_password  | string     | null: false                    |
| first_name          | string     | null: false                    |
| last_name           | string     | null: false                    |
| first_name_kana     | string     | null: false                    |
| last_name_kana      | string     | null: false                    |
| birth_date          | string     | null: false                    |

### Association
has_many :items
has_many :purchases


## itemsテーブル
| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| category            | string     | null: false                    |
| product             | string     | null: false                    |
| product_description | text       | null: false                    |
| condition           | string     | null: false                    |
| shipping_charges    | string     | null: false                    |
| area                | string     | null: false                    |
| shipping_days       | string     | null: false                    |
| price               | integer    | null: false                    |
| user_id             | integer    | null: false, foreign_key: true |
| purchase_id         | integer    | null: false, foreign_key: true |

### Association
belongs_to :user
belongs_to :purchase


## purchasesテーブル
| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| user_id             | integer    | null: false, foreign_key: true |

### Association
has_one    :item
belongs_to :user
has_many   :purchase_shippings
has_many   :shippings, through: :purchase_shippings


## shippingsテーブル
| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| postal_code         | integer    | null: false                    |
| prefectures         | string     | null: false                    |
| municipality        | string     | null: false                    |
| address1            | string     | null: false                    |
| address2            | string     |                                |
| phone               | integer    | null: false                    |

### Association
has_many :purchase_shippings
has_many :purchases, through: :purchase_shippings


## purchase_shippingsテーブル
| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| purchase_id         | integer    | null: false, foreign_key: true |
| shipping_id         | integer    | null: false, foreign_key: true |

### Association
belongs_to :purchase
belongs_to :shipping