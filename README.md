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
| birth_date          | date       | null: false                    |
| email               | string     | null: false, unique: true      |

### Association
has_many :items
has_many :purchase_shippings


## itemsテーブル
| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| category_id         | integer    | null: false                    |
| product             | string     | null: false                    |
| product_description | text       | null: false                    |
| condition_id        | integer    | null: false                    |
| shipping_charge_id  | integer    | null: false                    |
| area_id             | integer    | null: false                    |
| shipping_day_id     | integer    | null: false                    |
| price               | integer    | null: false                    |
| user                | references | null: false, foreign_key: true |

### Association
belongs_to :user
has_one    :purchase_shipping


## shippingsテーブル
| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| postal_code         | string     | null: false                    |
| area_id             | integer    | null: false                    |
| municipality        | string     | null: false                    |
| address1            | string     | null: false                    |
| address2            | string     |                                |
| phone               | string     | null: false                    |
| purchase_shipping   | references | null: false, foreign_key: true |

### Association
belongs_to :purchase_shipping


## purchase_shippingsテーブル
| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| item                | references | null: false, foreign_key: true |
| user                | references | null: false, foreign_key: true |

### Association
belongs_to :item
has_many :shippings
belongs_to :user