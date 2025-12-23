module Student
  class BatchesController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_student
    layout "student"
    def index
      @batches = Batch.includes(:course)
    end

    def show
      @batch = Batch.find(params[:id])

      enrollment = Enrollment.find_by!(
        user_id: current_user.id,
        batch_id: @batch.id,
        status: :approved
      )

      @classmates = User
        .joins(:enrollments)
        .where(enrollments: { batch_id: @batch.id, status: :approved })

      @progresses = Progress
        .where(batch_id: @batch.id)
        .index_by(&:user_id)
    end

    def enroll
      batch = Batch.find(params[:id])

      Enrollment.find_or_create_by!(
        user_id: current_user.id,
        batch_id: batch.id
      ) do |e|
        e.status = :pending
      end

      redirect_to student_batches_path,
        notice: "Enrollment request sent successfully."
    end

    private

    def ensure_student
      redirect_to root_path unless current_user.student?
    end
  end
end
