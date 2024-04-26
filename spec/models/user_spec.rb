require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe 'associations' do
    it { should have_many(:playlists) }
  end

  describe 'users' do
    it "should be able to create a new user" do
      user1 = User.create!(first_name: "John", last_name: "Doe", email: "lame@gmail.com", password: "1234password")
      user2 = User.create!(first_name: "Jane", last_name: "Doe", email: "lamby@gmail.com", password: "1265password")
      user3 = User.create!(first_name: "Bill", last_name: "Dot", email: "larre@gmail.com", password: "12345pass")

      expect(user1.first_name).to eq("John")
      expect(user1.last_name).to eq("Doe")
      expect(user1.email).to eq("lame@gmail.com")
      expect(user1.password).to be_a(String)
      expect(User.count).to eq(3)
    end

    it "cannot create a user with an existing email" do
      user1 = User.create!(first_name: "John", last_name: "Doe", email: "lame@gmail.com", password: "1234password")
      user2 = User.new(first_name: "Jane", last_name: "Doe", email: "lame@gmail.com", password: "1265password")
      playlist1 = Playlist.create!(name: "Favorite Songs", description: "doop doop", host_name: "fickhead", user_id: user1.id)

      user1.playlists << playlist1

      expect { user2.save! }.to raise_error(ActiveRecord::RecordInvalid)
      expect(user2.save).to eq(false)
      expect(User.count).to eq(1)
    end
  end
end
