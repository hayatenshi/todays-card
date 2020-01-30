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
|categories_id|integer|foreign_key: true|
## Association
- belongs_to :category
- has_many :article_images
- has_many :images, through: :article_images

## images table
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
## Association
- has_many :article_images
- has_many :articles, through: :article_images

## articles_images table
|Column|Type|Options|
|------|----|-------|
|articles_id|references|foreign_key: true|
|images_id|references|foreign_key: true|
## Association
- belongs_to :article
- belongs_to :image

## scrapings table
|Column|Type|Options|
|------|----|-------|
|code|string|null: false|
|categories_id|integer|foreign_key: true|
## Association
- belongs_to :category

## categories table
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
## Association
- has_many :articles
- has_many :scrapings