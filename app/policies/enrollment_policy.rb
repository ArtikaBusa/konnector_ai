class EnrollmentPolicy < ApplicationPolicy
  def create?
    user.student?
  end

  def approve?
    user.school_admin?
  end

  def reject?
    user.school_admin?
  end
end
