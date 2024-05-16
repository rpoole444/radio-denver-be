class JsonWebTokenService
  SECRET_KEY = 'your_secret_key'# eventually replace this with a hidden/ stronger key 

  def self.encode(payload)
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, { algorithm: 'HS256' })
    HashWithIndifferentAccess.new(decoded[0])
  rescue JWT::ExpiredSignature, JWT::VerificationError => e
    nil
  end
end
