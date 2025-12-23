module Api
  module V1
    class BatchesController < BaseController
      def index
        batches = policy_scope(Batch)

        batches = batches.where(course_id: params[:course_id]) if params[:course_id].present?

        if params[:active].present?
          today = Date.current
          batches = params[:active] == "true" ?
            batches.where("start_date <= ? AND end_date >= ?", today, today) :
            batches.where("end_date < ?", today)
        end

        paginated = batches.page(params[:page]).per(params[:per_page])

        render json: {
          data: paginated,
          meta: pagination_meta(paginated)
        }
      end

      def create
        course =
          Course.joins(:school)
                .where(schools: { school_admin_id: current_user.id })
                .find(params[:course_id])

        batch = course.batches.new(batch_params)
        authorize batch

        if batch.save
          render json: batch, status: :created
        else
          render json: batch.errors, status: :unprocessable_entity
        end
      end

      def classmates
        batch = Batch.find(params[:id])
        authorize batch, :classmates?

        students = batch.students.page(params[:page])
        render json: StudentSerializer.new(students, meta: pagination_meta(students))
      end

      private

      def batch_params
        params.require(:batch).permit(:name, :start_date, :end_date)
      end
    end
  end
end
