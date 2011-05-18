class Response < ActiveRecord::Base
  belongs_to :at_risk_event
  belongs_to :user
end
