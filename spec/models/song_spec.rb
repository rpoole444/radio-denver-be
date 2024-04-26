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
end
