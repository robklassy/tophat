class School < ApplicationRecord
  validates :name, presence: true

  has_many :courses
  has_many :faculties
  has_many :school_students
  has_many :students, through: :school_students
  has_many :school_professors
  has_many :professors, through: :school_professors
end
