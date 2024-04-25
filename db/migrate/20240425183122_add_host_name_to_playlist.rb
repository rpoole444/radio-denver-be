class AddHostNameToPlaylist < ActiveRecord::Migration[7.1]
  def change
    add_column :playlists, :host_name, :string
  end
end
