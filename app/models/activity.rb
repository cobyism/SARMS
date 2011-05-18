class Activity < ActiveRecord::Base
  belongs_to :unit
  has_many :attendances
end
