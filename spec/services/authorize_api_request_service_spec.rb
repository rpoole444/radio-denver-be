require 'rails_helper'

RSpec.describe AuthorizeApiRequestService, type: :service do
  describe '#result' do
    context 'when the Authorization header is present' do
      let(:user) { create(:user) }
      let(:headers) { { 'Authorization' => "Bearer #{JsonWebTokenService.encode(user_id: user.id)}" } }
      let(:service) { AuthorizeApiRequestService.new(headers) }

      it 'returns the user' do
        expect(service.result).to eq(user)
      end
    end

    context 'when the Authorization header is missing' do
      let(:headers) { {} }
      let(:service) { AuthorizeApiRequestService.new(headers) }

      it 'raises a RuntimeError' do
        expect { service.result }.to raise_error(RuntimeError, 'Missing token')
      end
    end

    context 'when the Authorization token is invalid' do
      let(:headers) { { 'Authorization' => 'Bearer invalid_token' } }
      let(:service) { AuthorizeApiRequestService.new(headers) }

      it "raises a JWT::DecodeError when the Authorization token is invalid" do
        headers = { 'Authorization' => 'invalid_token' }
        service = AuthorizeApiRequestService.new(headers)

        expect { service.result }.to raise_error(JWT::DecodeError)
      end
    end

    context 'when the user is not found' do
      let(:headers) { { 'Authorization' => "Bearer #{JsonWebTokenService.encode(user_id: 999999)}" } }
      let(:service) { AuthorizeApiRequestService.new(headers) }

      it 'raises a RuntimeError with "Invalid token" message' do
        expect { service.result }.to raise_error(RuntimeError, /Invalid token/)
      end
    end
  end
end
