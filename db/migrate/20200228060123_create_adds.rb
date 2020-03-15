class CreateAdds < ActiveRecord::Migration[5.0]
  def change
    create_table :adds do |t|
      t.string :artist
      t.string :song
      t.string :url
      t.references :user, foreign_key: true
      t.references :playlist, foreign_key: true
      t.timestamps
    end
  end
end
