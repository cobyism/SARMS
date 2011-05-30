class DashboardController < ApplicationController

  before_filter :authenticate_user!
  before_filter :set_tab

  def index
    @count = {
      :users => User.count,
      :students => User.students.count,
      :faculty => User.faculty.count,
      :admins => User.admins.count,
      :units => Unit.count,
      }
    
  end
  
  private
  
  def set_tab
    @tab = 'dashboard'
  end

end
