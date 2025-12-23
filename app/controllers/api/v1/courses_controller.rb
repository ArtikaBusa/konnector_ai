module Api
  module V1
    class CoursesController < BaseController
      def index
        courses = policy_scope(Course)
        courses = courses.where(school_id: params[:school_id]) if params[:school_id].present?
        courses = courses.where("name ILIKE ?", "%#{params[:name]}%") if params[:name].present?

        paginated = courses.page(params[:page]).per(params[:per_page])

        render json: {
          data: paginated,
          meta: pagination_meta(paginated)
        }
      end

      def create
        school = School.find_by!(school_admin_id: current_user.id)
        course = school.courses.new(course_params)
        authorize course

        if course.save
          render json: course, status: :created
        else
          render json: course.errors, status: :unprocessable_entity
        end
      end

      private

      def course_params
        params.require(:course).permit(:name)
      end
    end
  end
end
