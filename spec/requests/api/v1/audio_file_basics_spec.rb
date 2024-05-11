require 'rails_helper'

RSpec.describe "Files requests", type: :request do
  describe "GET index" do
    it "returns a list of files" do
      user = User.create!(first_name: "John", last_name: "Doe", email: "lamb@gmail.com", password: "1234password", password_confirmation: "1234password")
      file1 = user.files.create!(name: "file1", size: 100, s3_key: "key1")
      file2 = user.files.create!(name: "file2", size: 200, s3_key: "key2")

      get :index, params: { user_id: user.id }

      expect(response).to have_http_status(:success)
      expect(assigns(:files)).to match_array([file1, file2])
    end
  end

  describe "GET show" do
    it "returns a single file" do
      user = User.create!(first_name: "John", last_name: "Doe", email: "lamb@gmail.com", password: "1234password", password_confirmation: "1234password")
      file = user.files.create!(name: "file1", size: 100, s3_key: "key1")

      get :show, params: { user_id: user.id, id: file.id }

      expect(response).to have_http_status(:success)
      expect(assigns(:file)).to eq(file)
    end
  end

  describe "POST create" do
    it "creates a new file" do
      user = User.create!(first_name: "John", last_name: "Doe", email: "lamb@gmail.com", password: "1234password", password_confirmation: "1234password")
      file_params = { name: "new_file", size: 300, s3_key: "new_key" }

      expect {
        post :create, params: { user_id: user.id, file: file_params }
      }.to change(File, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(assigns(:file)).to be_a(File)
      expect(assigns(:file)).to be_persisted
    end
  end

  describe "DELETE destroy" do
    it "deletes a file" do
      user = User.create!(first_name: "John", last_name: "Doe", email: "lamb@gmail.com", password: "1234password", password_confirmation: "1234password")
      file = user.files.create!(name: "file1", size: 100, s3_key: "key1")

      expect {
        delete :destroy, params: { user_id: user.id, id: file.id }
      }.to change(File, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
