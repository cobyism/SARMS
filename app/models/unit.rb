class Unit < ActiveRecord::Base
  has_many :enrollments
  has_many :faculty_assignments
  has_many :activities
  has_many :assessments
  
  def full_name
    "#{self.code}—#{self.name}"
  end
  
  def trimester
    "Trimester #{self.term}, #{self.begins_at.year}"
  end
end
