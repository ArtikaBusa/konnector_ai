module Admin
  class DashboardController < ApplicationController

    def index
      @schools_count  = School.count
      @courses_count  = Course.count
      @batches_count  = Batch.count
      @students_count = User.student.count
    end
  end
end
