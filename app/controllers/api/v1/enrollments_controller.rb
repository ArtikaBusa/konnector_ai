module Api
  module V1
    class EnrollmentsController < BaseController
      def index
        enrollments = policy_scope(Enrollment)
        enrollments = enrollments.where(status: params[:status]) if params[:status].present?

        paginated = enrollments.page(params[:page]).per(params[:per_page])

        render json: {
          data: paginated,
          meta: pagination_meta(paginated)
        }
      end

      def create
        enrollment = Enrollment.new(
          user_id: current_user.id,
          batch_id: params[:batch_id],
          status: :pending
        )

        authorize enrollment

        if enrollment.save
          render json: enrollment, status: :created
        else
          render json: enrollment.errors, status: :unprocessable_entity
        end
      end

      def approve
        enrollment = Enrollment.find(params[:id])
        authorize enrollment, :approve?
        enrollment.approved_status!
        render json: enrollment
      end

      def reject
        enrollment = Enrollment.find(params[:id])
        authorize enrollment, :reject?
        enrollment.rejected_status!
        render json: enrollment
      end
    end
  end
end
