class Image < ApplicationRecord
  belongs_to :article, optional: true

  validates_presence_of :article
  validates :url, presence: true, uniqueness: true
end