class CourseProfessor < ApplicationRecord
  belongs_to :course
  belongs_to :user, polymorphic: true

  validates :user_type, inclusion: { in: ['Professor'],
    message: "%{value} must be Professor" }
end
