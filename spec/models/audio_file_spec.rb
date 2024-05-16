require 'rails_helper'

RSpec.describe AudioFile, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:size) }
    it { should validate_presence_of(:s3_key) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end
end
