class FacultyAssignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :unit

  validates_presence_of :user_id, :unit_id

  def user_name
    User.find(self.user_id).full_name
  end
  
  def unit_code
    Unit.find(self.unit_id).code
  end

  def unit_name
    Unit.find(self.unit_id).name
  end


end
