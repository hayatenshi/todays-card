class Image < ApplicationRecord
  belongs_to :article, optional: true

  validates_presence_of :article
end