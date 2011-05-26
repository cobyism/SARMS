class Unit < ActiveRecord::Base
  has_many :enrollments, :dependent => :destroy
  has_many :faculty_assignments, :dependent => :destroy
  has_many :activities, :dependent => :destroy
  has_many :assessments, :dependent => :destroy
  
  def full_name
    "#{self.code}—#{self.name}"
  end
  
  def trimester
    "Trimester #{self.term}, #{self.begins_at.year}"
  end
end
