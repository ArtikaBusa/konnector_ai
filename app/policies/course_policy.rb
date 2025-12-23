class CoursePolicy < ApplicationPolicy
  def index?
    user.school_admin?
  end

  def show?
    user.school_admin?
  end

  def create?
    user.school_admin?
  end

  def update?
    user.school_admin?
  end

  def destroy?
    user.school_admin?
  end

  class Scope < Scope
    def resolve
      if user.school_admin?
        scope.joins(:school)
             .where(schools: { school_admin_id: user.id })
      else
        scope.none
      end
    end
  end
end
