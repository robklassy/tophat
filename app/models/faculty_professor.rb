class FacultyProfessor < ApplicationRecord
  belongs_to :user, polymorphic: true
  belongs_to :faculty

  validates :user_type, inclusion: { in: ['Professor'],
    message: "%{value} must be Professor" }
end
