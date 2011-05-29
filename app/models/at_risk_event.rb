class AtRiskEvent < ActiveRecord::Base
  belongs_to :enrollment
  has_many :responses, :dependent => :destroy
  
  def response_received?
    return self.responses.count > 0
  end
end
