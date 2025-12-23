module SchoolAdmin
  class SchoolsController < SchoolAdmin::BaseController
    before_action :set_school

    def edit
      authorize @school
    end

    def update
      authorize @school
      if @school.update(school_params)
        redirect_to edit_school_admin_school_path, notice: "School updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_school
      @school = current_user.school
    end

    def school_params
      params.require(:school).permit(:name, :address)
    end
  end
end
