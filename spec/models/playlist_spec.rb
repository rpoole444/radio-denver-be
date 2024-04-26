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
end
