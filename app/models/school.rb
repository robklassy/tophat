class School < ApplicationRecord
  validates :name, presence: true

  has_many :courses
  has_many :faculties
end
