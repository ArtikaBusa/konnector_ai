class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: [:approve, :reject]

  # Student requests enrollment
  def create
    enrollment = Enrollment.new(
      user_id: current_user.id,
      batch_id: params[:batch_id],
      status: :pending
    )

    authorize enrollment

    if enrollment.save
      redirect_back fallback_location: root_path,
                    notice: "Enrollment request submitted."
    else
      redirect_back fallback_location: root_path,
                    alert: "Unable to submit enrollment request."
    end
  end

  # SchoolAdmin approves
  def approve
    authorize @enrollment, :approve?
    @enrollment.approved_status!

    redirect_back fallback_location: root_path,
                  notice: "Enrollment approved."
  end

  # SchoolAdmin rejects
  def reject
    authorize @enrollment, :reject?
    @enrollment.rejected_status!
    redirect_back fallback_location: root_path,
                  notice: "Enrollment rejected."
  end

  private

  def set_enrollment
    @enrollment = Enrollment.find(params[:id])
  end
end
