class Enrollment < ActiveRecord::Base
  belongs_to :user
  belongs_to :unit
  has_many :attendances, :dependent => :destroy
  has_many :at_risk_events, :dependent => :destroy
  has_many :notes, :dependent => :destroy
  has_many :performances, :dependent => :destroy

  validates_presence_of :user_id, :unit_id
  validates_uniqueness_of :user_id, :scope => :unit_id, :message => "is already enrolled in this unit"
  
  def user_name
    User.find(self.user_id).full_name if User.find(self.user_id)
  end
  
  def unit_code
    Unit.find(self.unit_id).code
  end

  def unit_name
    Unit.find(self.unit_id).name
  end
  
  def full_name
    "#{self.user.full_name} → #{self.unit.code}"
  end

end
