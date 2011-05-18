class Performance < ActiveRecord::Base
  belongs_to :assessment
  belongs_to :enrollment
end
