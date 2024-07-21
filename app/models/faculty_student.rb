class FacultyStudent < ApplicationRecord
  belongs_to :user, polymorphic: true
  belongs_to :faculty

  validates :user_type, inclusion: { in: ['Student'],
    message: "%{value} must be Student" }
end
