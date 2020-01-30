class RenameImageColumnToImage < ActiveRecord::Migration[5.2]
  def change
    rename_column :images, :image, :url
  end
end
