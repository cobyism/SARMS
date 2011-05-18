class Attendance < ActiveRecord::Base
  belongs_to :activity
  belongs_to :enrollment
end
