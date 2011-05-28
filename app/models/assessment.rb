class Assessment < ActiveRecord::Base
  belongs_to :unit
  belongs_to :enrollment
  has_many :performances, :dependent => :destroy
  
  def due
    self.due_at.strftime("Due %I:%M%p, %A, %e %B %Y") if self.due_at
  end
  
  def average_mark
    tally = 0
    count = 0
    self.performances.each do |p|
      tally += p.achieved_mark
      count += 1
    end
    tally / count
  end
  
  def highest_mark
    result = 0
    self.performances.each do |p|
      result = p.achieved_mark if p.achieved_mark > result
    end
    result
  end
  
  def lowest_mark
    result = self.total_marks
    self.performances.each do |p|
      result = p.achieved_mark if p.achieved_mark < result
    end
    result
  end
  
  def highest_percentage
    (self.highest_mark / self.total_marks * 100).round(2)
  end
  
  def lowest_percentage
    (self.lowest_mark / self.total_marks * 100).round(2)
  end
  
  def average_percentage
    (self.average_mark / self.total_marks * 100).round(2)
  end
end
