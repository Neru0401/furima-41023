## usersテーブル

| Column           | Type   | Options                 |
|------------------|--------|-------------------------|
| nickname         | string | null: false             |
| email            | string | null: false, unique: true|
| encrypted_password | string | null: false           |
| last_name        | string | null: false             |
| first_name       | string | null: false             |
| last_name_kana   | string | null: false             |
| first_name_kana  | string | null: false             |
| birth    | date   | null: false             |

## Association
has_many :items
has_many :purchases

## itemsテーブル

| Column          | Type       | Options                 |
|-----------------|------------|-------------------------|
| user            | references | null: false, foreign_key: true |
| title           | string     | null: false             |
| description     | text       | null: false             |
| category_id     | integer    | null: false             |
| condition_id    | integer    | null: false             |
| delivery_fee_id | integer    | null: false             |
| prefecture_id   | integer    | null: false             |
| ship_date_id    | integer    | null: false             |
| price           | integer    | null: false             |

## Association
belongs_to :user
has_one :purchase

## purchasesテーブル

| Column | Type       | Options                 |
|--------|------------|-------------------------|
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

## Association
belongs_to :item
belongs_to :user
has_one :shipping

## shippingsテーブル

| Column          | Type       | Options                 |
|-----------------|------------|-------------------------|
| purchase        | references | null: false, foreign_key: true |
| postal_code     | string     | null: false             |
| prefecture_id   | integer    | null: false             |
| city            | string     | null: false             |
| address         | string     | null: false             |
| building        | string     |                         |
| telephone_number | string    | null: false             |

## Association
belongs_to :purchase