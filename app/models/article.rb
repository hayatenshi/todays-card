class Article < ApplicationRecord
  belongs_to :category
  has_many :article_images
  has_many :images, through: :article_images
end
