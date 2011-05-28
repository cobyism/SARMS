class Performance < ActiveRecord::Base
  belongs_to :assessment
  belongs_to :enrollment
  
  validates_uniqueness_of :enrollment_id, :scope => :assessment_id
  validates_presence_of :enrollment_id
  validates_presence_of :assessment_id
  validates_presence_of :achieved_mark
  
  def result
    percentage = self.percentage.round(2)
    "#{self.achieved_mark}/#{self.assessment.total_marks} (#{percentage}%)"
  end
  
  def percentage
    return self.achieved_mark / self.assessment.total_marks * 100 if self.achieved_mark
    0
  end
  
  def grade
    p = self.percentage
    if p >= 80
      "HD"
    elsif p >= 70
      "D"
    elsif p >= 60
      "C"
    elsif p >= 50
      "P"
    else
      "N"
    end
  end
  
  def grade_in_words
    p = self.percentage
    if p >= 80
      "High Distinction"
    elsif p >= 70
      "Distinction"
    elsif p >= 60
      "Credit"
    elsif p >= 50
      "Pass"
    else
      "Fail"
    end
  end
end
