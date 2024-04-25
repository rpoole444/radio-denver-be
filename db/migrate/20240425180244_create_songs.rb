class CreateSongs < ActiveRecord::Migration[7.1]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :artist
      t.string :album
      t.integer :duration
      t.references :playlist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
