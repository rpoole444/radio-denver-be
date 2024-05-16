require 'rails_helper'

RSpec.describe JsonWebTokenService, type: :service do
  let(:payload) { { user_id: 1 } }
  let(:token) { JsonWebTokenService.encode(payload) }

  describe '.encode' do
    it 'encodes a payload into a JWT' do
      expect(token).to be_a(String)
    end
  end

  describe '.decode' do
    context 'with a valid token' do
      it 'decodes a JWT into a hash' do
        decoded_payload = JsonWebTokenService.decode(token)
        expect(decoded_payload).to eq(payload)
      end
    end

    context 'with an expired token' do
      it 'returns nil' do
        expired_payload = { user_id: 1, exp: Time.now.to_i - 3600 } # Expired 1 hour ago
        expired_token = JsonWebTokenService.encode(expired_payload)
        expect(JsonWebTokenService.decode(expired_token)).to be_nil
      end
    end

    context 'with an invalid token' do
      it 'raises a JWT::DecodeError' do
        invalid_token = 'invalid_token'
        expect { JsonWebTokenService.decode(invalid_token) }.to raise_error(JWT::DecodeError)
      end
    end
  end
end
