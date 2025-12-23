class Progress < ApplicationRecord
  belongs_to :user
  belongs_to :batch

  validates :completion_percentage,
            numericality: { in: 0..100 }
end
