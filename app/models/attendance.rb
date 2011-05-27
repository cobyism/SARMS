class Attendance < ActiveRecord::Base
  belongs_to :activity
  belongs_to :enrollment
  
  validates_uniqueness_of :enrollment_id, :scope => :activity_id, :message => "is already marked as attended for that activity"
end
