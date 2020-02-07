class Article < ApplicationRecord
  belongs_to :category
  has_many :images

  validates :title, :text, presence: true, uniqueness: true
  accepts_nested_attributes_for :images
end
