class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :unit
  has_many :attendances
  has_many :at_risk_events
  has_many :notes
  has_many :performances
end
