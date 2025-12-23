class EnrollmentSerializer < ActiveModel::Serializer
  attributes :id, :status

  belongs_to :user, serializer: UserSerializer
  belongs_to :batch, serializer: BatchSerializer
end
