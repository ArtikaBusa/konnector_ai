module SchoolAdmin
  class BatchesController < SchoolAdmin::BaseController
    before_action :set_course
    before_action :set_batch, only: %i[show edit update destroy add_student]

    def index
      @batches = policy_scope(@course.batches)
    end

    def show
      authorize @batch
      @students = User.students
                       .where.not(
                         id: @batch.enrollments.select(:user_id)
                       )
    end

    def new
      @batch = @course.batches.new
      authorize @batch
    end

    def create
      @batch = @course.batches.new(batch_params)
      authorize @batch

      if @batch.save
        redirect_to school_admin_course_batches_path(@course),
                    notice: "Batch created successfully"
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      authorize @batch
    end

    def update
      authorize @batch
      if @batch.update(batch_params)
        redirect_to school_admin_course_batches_path(@course),
                    notice: "Batch updated successfully"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize @batch
      @batch.destroy
      redirect_to school_admin_course_batches_path(@course),
                  notice: "Batch deleted successfully"
    end

    def add_student
      authorize @batch

      Enrollment.create!(
        user_id: params[:student_id],
        batch: @batch,
        status: :pending
      )

      redirect_to school_admin_course_batch_path(@course, @batch),
                  notice: "Student added successfully"
    end

    private

    def set_course
      @course = Course
        .joins(:school)
        .where(schools: { school_admin_id: current_user.id })
        .find(params[:course_id])
    end

    def set_batch
      @batch = @course.batches.find(params[:id])
    end

    def batch_params
      params.require(:batch).permit(:name, :start_date, :end_date)
    end
  end
end
