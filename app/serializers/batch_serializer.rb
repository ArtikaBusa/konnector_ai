class BatchSerializer < ActiveModel::Serializer
  attributes :id, :name, :start_date, :end_date, :course_id
end
