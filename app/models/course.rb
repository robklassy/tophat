class Course < ApplicationRecord
  belongs_to :school
  belongs_to :faculty

  validates :name, presence: true
  validates :course_code, presence: true
  validates :school_id, presence: true
  validates :faculty_id, presence: true

  validate :faculty_in_school

  def faculty_in_school
    f = Faculty.find(faculty_id)
    s = School.find(school_id)
    if s.id != f.school_id
      errors.add(:faculty, "Faculty does not belong to School")
    end
  end  
end
