require "rails_helper"

RSpec.describe "API::V1::Schools", type: :request do
  let!(:admin) { create(:user, :admin) }
  let!(:school) { create(:school) }

  it "returns paginated schools for admin" do
    get "/api/v1/schools", headers: auth_headers(admin)

    body = JSON.parse(response.body)

    expect(response).to have_http_status(:ok)
    expect(body["data"].length).to eq(1)
    expect(body["meta"]).to include("current_page", "total_pages")
  end

  it "prevents non-admin access" do
    student = create(:user, :student)

    get "/api/v1/schools", headers: auth_headers(student)

    expect(response).to have_http_status(:forbidden)
  end
end
