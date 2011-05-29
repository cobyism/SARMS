class AtRiskEvent < ActiveRecord::Base
  belongs_to :enrollment
  has_many :responses, :dependent => :destroy
  
  validates_presence_of :enrollment_id
  
  def response_received?
    return self.responses.count > 0
  end
end
