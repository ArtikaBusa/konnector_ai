module SchoolAdmin
  class EnrollmentsController < BaseController
    def index
      @enrollments =
        Enrollment
          .joins(batch: { course: :school })
          .where(
            schools: { school_admin_id: current_user.id },
          )
          .includes(:user, :batch)

    end

    def approve
      enrollment = Enrollment.find(params[:id])
      authorize enrollment

      enrollment.update!(status: :approved)

      redirect_to school_admin_enrollments_path,
                  notice: "Enrollment approved"
    end

    def reject
      enrollment = Enrollment.find(params[:id])
      authorize enrollment

      enrollment.update!(status: :rejected)

      redirect_to school_admin_enrollments_path,
                  alert: "Enrollment rejected"
    end
  end
end
