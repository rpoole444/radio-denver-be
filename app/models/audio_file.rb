class AudioFile < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :size, presence: true
  validates :s3_key, presence: true
end
