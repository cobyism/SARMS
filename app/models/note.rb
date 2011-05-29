class Note < ActiveRecord::Base
  belongs_to :enrollment
  belongs_to :user
  
  validates_presence_of :enrollment_id, :user_id, :content
end
