class Assessment < ActiveRecord::Base
  belongs_to :unit
  has_many :performances
end
