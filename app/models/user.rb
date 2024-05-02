class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, length: { minimum: 10, maximum: 15 }, allow_blank: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  has_many :playlists, dependent: :destroy
end
