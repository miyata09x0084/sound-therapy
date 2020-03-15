class CreateEmotions < ActiveRecord::Migration[5.0]
  def change
    create_table :emotions do |t|
      t.float :anger
      t.float :contempt
      t.float :disgust
      t.float :fear
      t.float :happiness
      t.float :neutral
      t.float :sadness
      t.float :surprise
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
