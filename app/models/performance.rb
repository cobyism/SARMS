class Performance < ActiveRecord::Base
  belongs_to :assessment
  belongs_to :enrollment
  
  validates_uniqueness_of :enrollment_id, :scope => :assessment_id
  validates_presence_of :enrollment_id
  validates_presence_of :assessment_id
  validates_presence_of :achieved_mark
  
  def result
    percentage = self.percentage
    "#{self.achieved_mark}/#{self.assessment.total_marks} (#{percentage}%)"
  end
  
  def percentage
    return self.achieved_mark / self.assessment.total_marks * 100 if self.achieved_mark
    0
  end
end
