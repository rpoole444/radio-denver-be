class AddDescriptionToPlaylist < ActiveRecord::Migration[7.1]
  def change
    add_column :playlists, :description, :string
  end
end
