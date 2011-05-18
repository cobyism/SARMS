class Note < ActiveRecord::Base
  belongs_to :enrollment
  belongs_to :user
end
