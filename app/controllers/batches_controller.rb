class BatchesController < ApplicationController
  def classmates
    @batch = Batch.find(params[:id])
    authorize @batch, :classmates?

    @students = @batch.users.includes(:progresses)
  end
end
