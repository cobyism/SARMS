class Unit < ActiveRecord::Base
  has_many :enrollments
  has_many :faculty_assignments
  has_many :activities
  has_many :assessments
end
