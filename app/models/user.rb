class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, length: { minimum: 10, maximum: 15 }, allow_blank: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  has_many :playlists, dependent: :destroy
  has_many :audio_files, dependent: :destroy

  def generate_password_token!
    self.reset_password_token = SecureRandom.hex(10)
    self.reset_password_sent_at = Time.now.utc
    save!
  end

  def password_token_valid?
    (self.reset_password_sent_at + 4.hours) > Time.now.utc
  end

  def reset_password!(password, password_confirmation)
    if password_token_valid?
      self.reset_password_token = nil
      self.password = password
      self.password_confirmation = password_confirmation
      save
    else
      errors.add(:base, "Password reset token has expired")
      false
    end
  end
end
