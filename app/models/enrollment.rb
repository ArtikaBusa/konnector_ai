class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :batch

  enum :status, {
    pending: 0,
    approved: 1,
    rejected: 2
  }, suffix: true

  validates :status, presence: true
end
