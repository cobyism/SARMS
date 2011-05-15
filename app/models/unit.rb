class Unit < ActiveRecord::Base
  has_many :enrollments
  has_many :faculty_assignments
end
