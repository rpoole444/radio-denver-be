require "rails_helper"

RSpec.describe "create a new user endpoint", type: :request do
  describe "POST /api/v1/users" do
    it "creates a new user in the database" do
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

    it "sends back a 422 if the user is not created" do
      post "/api/v1/users", params: {
        user: {
          first_name: "",
          last_name: "",
          email: "",
          password: "",
          password_confirmation: ""
        }
      }.to_json, headers: { "Content-Type" => "application/json", "Accept" => "application/json" }

      json_response = JSON.parse(response.body)

      expect(response.status).to eq(422)
      expect(json_response["errors"]).to eq(["Password can't be blank", "First name can't be blank", "Last name can't be blank", "Email can't be blank", "Password digest can't be blank"])
    end
  end
end
