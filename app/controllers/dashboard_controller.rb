class DashboardController < ApplicationController

  before_filter :authenticate_user!

  def index
    @count = {
      :users => User.count,
      :students => User.students.count,
      :faculty => User.faculty.count,
      :admins => User.admins.count,
      :units => Unit.count,
      }
    
  end

end
