class CourseStudent < Application
  belongs_to :course
  belongs_to :student, foreign_key: :user_id

  validates :user_type, inclusion: { in: ['Student'],
    message: "%{value} must be Student" }
end
