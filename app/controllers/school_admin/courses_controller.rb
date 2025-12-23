module SchoolAdmin
  class CoursesController < SchoolAdmin::BaseController
    before_action :set_school
    before_action :set_course, only: [:edit, :update, :destroy]

    def index
      @courses = policy_scope(Course)
    end

    def new
      @course = @school.courses.new
      authorize @course
    end

    def create
      @course = @school.courses.new(course_params)
      authorize @course

      if @course.save
        redirect_to school_admin_courses_path,
                    notice: "Course created successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      authorize @course
    end

    def update
      authorize @course

      if @course.update(course_params)
        redirect_to school_admin_courses_path,
                    notice: "Course updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize @course
      @course.destroy
      redirect_to school_admin_courses_path,
                  notice: "Course deleted successfully."
    end

    private

    def set_school
      @school = School.find_by!(school_admin_id: current_user.id)
    end

    def set_course
      @course = @school.courses.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:name)
    end
  end
end
