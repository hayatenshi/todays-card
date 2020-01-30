class Image < ApplicationRecord
  has_many :article_images
  has_many :articles, through: :article_images

  # mount_uploader :image, ImageUploader
end
