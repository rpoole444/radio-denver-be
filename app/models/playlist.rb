class Playlist < ApplicationRecord
  belongs_to :user
  has_many :songs

  validates :name, presence: true
  validates :description, presence: true
  validates :host_name, presence: true
end
