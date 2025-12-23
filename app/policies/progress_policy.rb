class ProgressPolicy < ApplicationPolicy
  def show?
    user.student? &&
      record.batch.students.exists?(user.id)
  end

  def update?
    user.school_admin?
  end

  class Scope < Scope
    def resolve
      if user.student?
        scope.where(user_id: user.id)
      elsif user.school_admin?
        scope.joins(batch: { course: :school })
             .where(schools: { school_admin_id: user.id })
      else
        scope.none
      end
    end
  end
end
