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

## articles table
|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|text|string|null: false|
|category_id|references|foreign_key: true|
## Association
- belongs_to :category
- has_many :images

## images table
|Column|Type|Options|
|------|----|-------|
|url|string|null: false|
|article_id|references|foreign_key: true|
## Association
- belongs_to :article

## categories table
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
## Association
- has_many :articles