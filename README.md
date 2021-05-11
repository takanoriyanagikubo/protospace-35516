# テーブル設計

## users テーブル

| Column     | Type   | Options     |
| ---------- | ------ | ----------- |
| email      | string | null: false |
| password   | string | null: false |
| name       | string | null: false |
| profile    | text   | null: false |
| occupation | text   | null: false |
| position   | text   | null: false |



### Association

- has_many :prptotype
- has_many :comments
- has_many :prototype, through: :comments


## prototypes テーブル

| Column     | Type      | Options     |
| ---------- | --------- | ----------- |
| title      | string    | null: false |
| catch_copy | text      | null: false |
| concept    | text      | null: false |
| image      | string    | null: false |
| user       | reference | null: false |

### Association

- belongs_to :users
- has_many :comments
- has_many :users, through: :comments


## comments テーブル

| Column    | Type       | Options     |
| --------- | ---------- | ----------- |
| text      | text       | null: false |
| user      | references | null: false |
| prototype | references | null: false |

### Association

- belongs_to :users
- belongs_to :prototypes

