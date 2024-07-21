class SchoolProfessor < ApplicationRecord
  belongs_to :user, polymorphic: true
  belongs_to :school

  validates :user_type, inclusion: { in: ['Professor'],
    message: "%{value} must be Professor" }
end
