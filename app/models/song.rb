class Song < ApplicationRecord
  belongs_to :playlist

  validates :name, presence: true
  validates :artist, presence: true
  validates :album, presence: true
  validates :duration, presence: true
end
