class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :host_name, :string
    add_column :users, :description, :string
    add_column :users, :profile_image, :string
    add_column :users, :phone_number, :string
  end
end
