class AtRiskEvent < ActiveRecord::Base
  belongs_to :enrollment
  has_many :responses, :dependent => :destroy
end
