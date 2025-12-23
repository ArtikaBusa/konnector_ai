require "rails_helper"

RSpec.describe "API::V1::Courses", type: :request do
  let!(:school_admin) { create(:user, :school_admin) }
  let!(:school) { create(:school, school_admin: school_admin) }
  let!(:course) { create(:course, school: school) }

  it "lists courses for school admin" do
    get "/api/v1/courses", headers: auth_headers(school_admin)

    expect(response).to have_http_status(:ok)
  end

  it "filters by school_id" do
    get "/api/v1/courses?school_id=#{school.id}",
        headers: auth_headers(school_admin)

    body = JSON.parse(response.body)
    expect(body["data"].first["school_id"]).to eq(school.id)
  end
end
