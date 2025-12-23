class School < ApplicationRecord
  belongs_to :school_admin, class_name: "User"

  has_many :courses, dependent: :destroy

  validates :name, presence: true
end
