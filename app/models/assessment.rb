class Assessment < ActiveRecord::Base
  belongs_to :unit
  has_many :performances, :dependent => :destroy
  
  def due
    self.due_at.strftime("Due %I:%M%p, %A, %e %B %Y") if self.due_at
  end
end
