class BatchPolicy < ApplicationPolicy
  def index?
    user.school_admin?
  end

  def show?
    owns_batch?
  end

  def create?
    owns_course?
  end

  def update?
    owns_batch?
  end

  def destroy?
    owns_batch?
  end

  def add_student?
    owns_batch?
  end

  class Scope < Scope
    def resolve
      scope.joins(course: :school)
           .where(schools: { school_admin_id: user.id })
    end
  end

  private

  def owns_batch?
    record.course.school.school_admin_id == user.id
  end

  def owns_course?
    record.course.school.school_admin_id == user.id
  end
end
