class Performance < ActiveRecord::Base
  belongs_to :assessment
  belongs_to :enrollment
  
  validates_uniqueness_of :enrollent_id, :scope => :assessment_id
end
