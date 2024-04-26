require "rails_helper"

RSpec.describe "create a new user endpoint", type: :request do
  describe "POST /api/v1/users" do
    it "creates a new user in the database" do
      headers = { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json" }
      post "/api/v1/users", params: {
        user: {
          first_name: "Jerry",
          last_name: "Seinfeld",
          email: "pinebreeze@millionz.cloudflare.com",
          password: "shy_guy_23",
          password_confirmation: "shy_guy_23"
        }
      }.to_json, headers: { "Content-Type" => "application/json", "Accept" => "application/json" }

      json_response = JSON.parse(response.body)

      expect(response.status).to eq(201)
      expect(json_response["data"]["attributes"]["first_name"]).to eq("Jerry")
    end
  end
end
