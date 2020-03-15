class AddImageToPlaylists < ActiveRecord::Migration[5.0]
  def change
    add_column :playlists, :image, :string
  end
end
