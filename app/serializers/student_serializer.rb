class StudentSerializer
  include JSONAPI::Serializer

  set_type :student

  attributes :id, :name, :email

  attribute :progress_percentage do |student|
    # Safe default if progress logic not implemented yet
    student.progress_percentage || 0
  end

  attribute :batch_ids do |student|
    student.batches.pluck(:id)
  end
end
