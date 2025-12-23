require "rails_helper"

RSpec.describe "API Login", type: :request do
  let!(:user) { create(:user, :school_admin) }

  it "logs in with valid credentials" do
    post "/api/v1/login",
     params: {
       email: user.email,
       password: "password"
     }.to_json,
     headers: json_headers


    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)["token"]).to be_present
  end

  it "rejects invalid credentials" do
    post "/api/v1/login", params: {
      email: user.email,
      password: "wrong"
    }

    expect(response).to have_http_status(:unauthorized)
  end
end
