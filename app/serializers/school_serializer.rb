class SchoolSerializer < ActiveModel::Serializer
  attributes :id, :name, :address

  belongs_to :school_admin, serializer: UserSerializer
end
