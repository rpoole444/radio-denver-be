class JsonWebTokenService
  SECRET_KEY = 'your_secret_key'# eventually replace this with a hidden/ stronger key

  def self.encode(payload)
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, { algorithm: 'HS256' }).first
    symbolized_payload = symbolize_keys(decoded)
    symbolized_payload
  rescue JWT::ExpiredSignature, JWT::VerificationError => e
    nil
  end

  def self.symbolize_keys(value)
    case value
    when Array
      value.map { |v| symbolize_keys(v) }
    when Hash
      value.transform_keys { |k| k.to_sym }
    else
      value
    end
  end
end
