class CreateScrapings < ActiveRecord::Migration[5.2]
  def change
    create_table :scrapings do |t|
      t.text :code, null: false
      t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
