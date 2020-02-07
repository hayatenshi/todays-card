class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title, null: false, unique: true
      t.string :text,  null: false, unique: true
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
