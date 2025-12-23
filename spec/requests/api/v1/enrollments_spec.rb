require "rails_helper"

RSpec.describe "API::V1::Enrollments", type: :request do
  let!(:student) { create(:user, :student) }
  let!(:school_admin) { create(:user, :school_admin) }
  let!(:school) { create(:school, school_admin: school_admin) }
  let!(:course) { create(:course, school: school) }
  let!(:batch) { create(:batch, course: course) }

  it "allows student to request enrollment" do
    post "/api/v1/enrollments",
         params: { batch_id: batch.id }.to_json,
         headers: auth_headers(student)

    expect(response).to have_http_status(:created)
  end

  it "allows school admin to approve enrollment" do
    enrollment = create(:enrollment, batch: batch, user: student)

    patch "/api/v1/enrollments/#{enrollment.id}/approve",
          headers: auth_headers(school_admin)

    expect(response).to have_http_status(:ok)
    expect(enrollment.reload.status).to eq("approved")
  end
end
