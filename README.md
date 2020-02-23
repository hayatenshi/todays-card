# README

## App URL
### **https://todays-card.herokuapp.com**


## Description
This app is an automatic post blog using scraping.

This app scrapes the following sites.
- `https://cf-vanguard.com/todays-card/`
- `https://ws-tcg.com/todays-card/`
- `https://fc-buddyfight.com/todays-card/`

The timing for updating articles is as follows.
- vanguard : Every day 1:30 AM UTC
- Weiβ Schwarz : Every day 3:00 AM UTC
- Buddyfight : Every day 9:00 AM UTC


## data base
## articles table
|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
|text|string|null: false|
|category_id|references|foreign_key: true|
### Association
- belongs_to :category
- has_many :images


## images table
|Column|Type|Options|
|------|----|-------|
|url|string|null: false|
|article_id|references|foreign_key: true|
### Association
- belongs_to :article


## categories table
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :articles


## Author
- [GitHub]:https://github.com/hayatenshi
- [Twitter]:https://twitter.com/Brave_the_Front

©︎Copyright 2020 Todays CARD


## Copyright notice
The card images used on this site have been obtained and reposted from the
Cardfight!! Vanguard Official Portal Site(http://cf-vanguard.com/), in
accordance to the guidelines stated there. Re-use of these images(re-post,
distribution) is strictly prohibited.
(C)bushiroad All Rights Reserved. 

The card images used on this site have been obtained and reposted from the
Future Card Buddyfight Official Portal Site(http://fc-buddyfight.com/), in
accordance to the guidelines stated there. Re-use of these images(re-post,
distribution) is strictly prohibited.
(C)bushiroad All Rights Reserved. 

The copyright of all card images on this blog belongs to the management source.