class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, {
    admin: 0,
    school_admin: 1,
    student: 2
  }

  validates :role, presence: true
  validates :name, presence: true

  has_many :enrollments, foreign_key: :student_id
  has_many :batches, through: :enrollments
  has_many :progresses
  has_one :school, foreign_key: :school_admin_id, dependent: :destroy


  before_create :generate_authentication_token

  scope :students, -> { where(role: :student) }

  def generate_authentication_token
    self.authentication_token = SecureRandom.hex(20)
  end

end
