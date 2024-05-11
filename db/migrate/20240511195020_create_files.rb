class CreateFiles < ActiveRecord::Migration[7.1]
  def change
    create_table :files do |t|
      t.string :name
      t.integer :size
      t.string :s3_key
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
