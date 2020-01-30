class CreateArticleImages < ActiveRecord::Migration[5.2]
  def change
    create_table :article_images do |t|
      t.references :article, foreign_key: true
      t.references :image, foreign_key: true
      t.timestamps
    end
  end
end
