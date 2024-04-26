require 'rails_helper'

RSpec.describe Playlist, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :host_name }
  end

  describe 'associations' do
    it { should belong_to :user }
    it { should have_many :songs }
  end

  describe 'playlist creation' do
    it 'can be created' do
      user1 = User.create!(first_name: "John", last_name: "Doe", email: "lame@gmail.com", password: "1234password")
      playlist1 = Playlist.create!(name: "Favorite Songs", description: "doop doop", host_name: "fickhead", user: user1)

      expect(user1.playlists.count).to eq(1)
      expect(playlist1.songs.count).to eq(0)
      expect(playlist1.user).to eq(user1)
      expect(playlist1.name).to eq("Favorite Songs")
    end

    it 'needs a user' do
      playlist1 = Playlist.new(name: "Favorite Songs", description: "doop doop", host_name: "fickhead")

      expect(playlist1.valid?).to eq(false)
      expect(playlist1.save).to eq(false)
      expect { playlist1.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
