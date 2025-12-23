class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404

  protected

  def after_sign_in_path_for(resource)
    case resource.role
    when "admin"
      admin_dashboard_path
    when "school_admin"
      school_admin_courses_path
    when "student"
      student_root_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  private

  def user_not_authorized
    redirect_to new_user_session_path, alert: "You are not authorized."
  end

  def render_404
    respond_to do |format|
      format.html { render file: Rails.public_path.join("404.html"), status: :not_found, layout: false }
      format.json { render json: { error: "Not Found" }, status: :not_found }
    end
  end

  def render_403
    respond_to do |format|
      format.html { redirect_to root_path, alert: "You are not authorized to access this page." }
      format.json { render json: { error: "Forbidden" }, status: :forbidden }
    end
  end
end
