module Api
  module V1
    class SchoolsController < BaseController
      def index
        authorize School   # 🔥 THIS IS THE KEY LINE

        schools = policy_scope(School)
        paginated = schools.page(params[:page]).per(params[:per_page])

        render json: {
          data: paginated,
          meta: pagination_meta(paginated)
        }
      end

      def show
        school = School.find(params[:id])
        authorize school
        render json: school
      end

      def create
        school = School.new(school_params)
        authorize school

        if school.save
          render json: school, status: :created
        else
          render json: school.errors, status: :unprocessable_entity
        end
      end

      private

      def school_params
        params.require(:school).permit(:name, :address, :school_admin_id)
      end
    end
  end
end
