module Admin
  class SchoolsController < Admin::BaseController
    before_action :set_school, only: [:show, :edit, :update, :destroy]

    def index
      @schools = policy_scope(School).page(params[:page]).per(10)
    end

    def show
      authorize @school
    end

    def new
      @school = School.new
      authorize @school
    end

    def create
      @school = School.new(school_params)
      authorize @school

      if @school.save
        redirect_to admin_schools_path, notice: "School created successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      authorize @school
    end

    def update
      authorize @school

      if @school.update(school_params)
        redirect_to admin_schools_path, notice: "School updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize @school
      @school.destroy
      redirect_to admin_schools_path, notice: "School deleted successfully."
    end

    private

    def set_school
      @school = School.find(params[:id])
    end

    def school_params
      params.require(:school).permit(:name, :address, :school_admin_id)
    end
  end
end
