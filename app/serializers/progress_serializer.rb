class ProgressSerializer < ActiveModel::Serializer
  attributes :id, :completion_percentage

  belongs_to :user, serializer: UserSerializer
  belongs_to :batch, serializer: BatchSerializer
end
