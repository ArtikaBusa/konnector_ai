require "rails_helper"

RSpec.describe "API::V1::Batches", type: :request do
  let!(:school_admin) { create(:user, :school_admin) }
  let!(:school) { create(:school, school_admin: school_admin) }
  let!(:course) { create(:course, school: school) }
  let!(:batch1) { create(:batch, course: course) }
  let!(:batch2) { create(:batch, course: course) }

  it "paginates batches" do
    get "/api/v1/batches?page=1&per_page=1",
        headers: json_headers(school_admin)

    body = JSON.parse(response.body)
    expect(response).to have_http_status(:ok)
    expect(body["data"].length).to eq(1)
    expect(body["meta"]["total_count"]).to eq(2)
  end
end
