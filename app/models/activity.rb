class Activity < ActiveRecord::Base
  belongs_to :unit
  has_many :attendances, :dependent => :destroy
  
  validates_presence_of :name, :date, :unit_id
end
