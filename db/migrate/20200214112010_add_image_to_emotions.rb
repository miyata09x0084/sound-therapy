class AddImageToEmotions < ActiveRecord::Migration[5.0]
  def change
    add_column :emotions, :image, :string
  end
end
