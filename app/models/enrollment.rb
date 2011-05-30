class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :unit
  has_many :attendances, :dependent => :destroy
  has_many :at_risk_events, :dependent => :destroy
  has_many :notes, :dependent => :destroy
  has_many :performances, :dependent => :destroy

  validates_presence_of :user_id, :unit_id
  validates_uniqueness_of :user_id, :scope => :unit_id, :message => "is already enrolled in this unit"
  
  def attendance_count
    self.attendances.count
  end
  
  def attendance_percentage
    self.attendance_count / self.unit.activities.count * 100
  end
  
  def performance_percentage
    total = 0
    count = 0
    self.performances.each do |p|
      total += p.percentage
      count += 1
    end
    total / count
  end
  
  def user_name
    User.find(self.user_id).full_name if User.find(self.user_id)
  end
  
  def unit_code
    Unit.find(self.unit_id).code
  end

  def unit_name
    Unit.find(self.unit_id).name
  end
  
  def full_name
    "#{self.user.full_name} → #{self.unit.code}"
  end
  
  def has_attended_enough
    attendance_count = self.attendances.count
    return attendance_count > (self.unit.activities.count / 2)
  end
  
  def has_submitted_all_assignments
    performances_count = self.performances.count
    return performances_count == self.unit.assessments.count
  end
  
  def is_at_risk?
    return true unless self.has_attended_enough && self.has_submitted_all_assignments
    return false
  end
  
  def at_risk_reasons
    reasons = Array.new
    reasons << "More than half of the activities have not been attended." unless self.has_attended_enough
    reasons << "One or more assessment items are not complete." unless self.has_submitted_all_assignments
    reasons << "Not at risk." if self.has_attended_enough && self.has_submitted_all_assignments
    return reasons
  end

end
