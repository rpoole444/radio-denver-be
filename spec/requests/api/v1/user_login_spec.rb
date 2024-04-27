require "rails_helper"

RSpec.describe "user login", type: :request do
  describe "create session" do
    it "should create a session for an existing user" do
      user1 = User.create!(first_name: "John", last_name: "Doe", email: "lame@gmail.com", password: "1234password", password_confirmation: "1234password")

      post "/api/v1/sessions", params: {
        email: user1.email,
        password: "1234password"
      }.to_json, headers: { "Content-Type" => "application/json", "Accept" => "application/json" }

      json_response = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json_response["data"]["id"]).to eq(user1.id.to_s)
    end

    it "should not create a session for a non-existing user" do
      user1 = User.create!(first_name: "John", last_name: "Doe", email: "lame@gmail.com", password: "1234password", password_confirmation: "1234password")

      post "/api/v1/sessions", params: {
        email: "wrong@error.nope",
        password: "1234password"
      }.to_json, headers: { "Content-Type" => "application/json", "Accept" => "application/json" }

      json_response = JSON.parse(response.body)

      expect(response.status).to eq(401)
      expect(json_response["error"]).to eq("Invalid email or password")
    end

    it "should not create a session for a wrong password" do
      user1 = User.create!(first_name: "John", last_name: "Doe", email: "lame@gmail.com", password: "1234password", password_confirmation: "1234password")

      post "/api/v1/sessions", params: {
        email: user1.email,
        password: "wrong666"
      }.to_json, headers: { "Content-Type" => "application/json", "Accept" => "application/json" }

      json_response = JSON.parse(response.body)

      expect(response.status).to eq(401)
      expect(json_response["error"]).to eq("Invalid email or password")
    end
  end
end
