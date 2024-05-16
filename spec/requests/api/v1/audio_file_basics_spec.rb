require 'rails_helper'

RSpec.describe "Files requests", type: :request do
  xdescribe "POST /users/:user_id/audio_files" do
    it "creates a new file" do
      user = User.create!(first_name: "John", last_name: "Doe", email: "lamb@gmail.com", password: "1234password", password_confirmation: "1234password")
      file_params = { name: "new_file", size: 300, s3_key: "new_key" }

      expect {
        post "/api/v1/users/#{user.id}/audio_files", params: { audio_file: file_params }
      }.to change(AudioFile, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(assigns(:audio_file)).to be_a(AudioFile)
      expect(assigns(:audio_file)).to be_persisted
    end
  end
end
