require 'rails_helper'

RSpec.describe Song, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :artist }
    it { should validate_presence_of :album }
    it { should validate_presence_of :duration }
  end

  describe 'associations' do
    it { should belong_to :playlist }
  end

  describe 'song creation' do
    it 'can be created with valid attributes' do
      user1 = User.create!(first_name: "John", last_name: "Doe", email: "lame@gmail.com", password: "1234password")
      playlist1 = Playlist.create!(name: "Favorite Songs", description: "doop doop", host_name: "fickhead", user: user1)
      song1 = playlist1.songs.create!(name: "I get it", artist: "Boingggg", album: "Boingggin hard", duration: 300)
      song2 = playlist1.songs.create!(name: "Flip u the Bird", artist: "D-Raybies", album: "D-Raybies' Babies", duration: 350)

      expect(song1.name).to eq("I get it")
      expect(song2.name).to eq("Flip u the Bird")
      expect(song1.artist).to eq("Boingggg")
      expect(Song.count).to eq(2)
    end

    it "needs a playlist to be created" do
      song1 = Song.new(name: "I get it", artist: "Boingggg", album: "Boingggin hard", duration: 300)

      expect(song1.save).to eq(false)
      expect { song1.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
