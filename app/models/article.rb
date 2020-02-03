class Article < ApplicationRecord
  belongs_to :category
  has_many :article_images
  has_many :images, through: :article_images

  accepts_nested_attributes_for :images
end
