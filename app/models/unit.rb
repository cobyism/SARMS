class Unit < ActiveRecord::Base
  has_many :enrollments, :dependent => :destroy
  has_many :faculty_assignments, :dependent => :destroy
  has_many :activities, :dependent => :destroy
  has_many :assessments, :dependent => :destroy
  
  validates_presence_of :code, :name, :begins_at, :ends_at, :term
  
  def full_name
    "#{self.code}—#{self.name}"
  end
  
  def trimester
    "Trimester #{self.term}, #{self.begins_at.year}"
  end
  
  def number_of_students_at_risk
    count = 0
    self.enrollments.each do |e|
      if e.is_at_risk?
        count += 1
      end
    end
    return count
  end
  
  def has_students_at_risk?
    result = false
    self.enrollments.each do |e|
      if e.is_at_risk?
        result = true
        break
      end
    end
    return result
  end
end
