module Student
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_student
    layout "student"

    def index
      @enrollments = Enrollment
        .includes(batch: :course)
        .where(user_id: current_user.id)
    end

    private

    def ensure_student
      redirect_to root_path unless current_user.student?
    end
  end
end
