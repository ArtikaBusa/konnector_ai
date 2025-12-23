module SchoolAdmin
  class BaseController < ApplicationController
    layout "admin"

    before_action :authenticate_user!
    before_action :ensure_school_admin!

    include Pundit::Authorization

    rescue_from Pundit::NotAuthorizedError do
      redirect_to root_path, alert: "Not authorized"
    end

    def current_school
      @current_school ||= School.find_by!(school_admin_id: current_user.id)
    end
    helper_method :current_school

    private

    def ensure_school_admin!
      redirect_to root_path unless current_user.school_admin?
    end
  end
end
