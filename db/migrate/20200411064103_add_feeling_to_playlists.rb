class AddFeelingToPlaylists < ActiveRecord::Migration[5.0]
  def change
    add_column :playlists, :feeling, :string
  end
end
