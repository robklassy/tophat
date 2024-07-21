class SchoolStudent < ApplicationRecord
  belongs_to :user, polymorphic: true
  belongs_to :school

  validates :user_type, inclusion: { in: ['Student'],
    message: "%{value} must be Student" }
end
