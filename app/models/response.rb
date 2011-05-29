class Response < ActiveRecord::Base
  belongs_to :at_risk_event
  belongs_to :user
  
  validates_presence_of :user_id, :at_risk_event_id, :response
end
