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
      
    
    @at_risk_count = 0
    @at_risk_notified = 0
    @at_risk_not_notified = 0
    @at_risk_responded = 0
    @at_risk_not_responded = 0
    Enrollment.all.each do |e|
      if e.is_at_risk?
        @at_risk_count += 1
        if AtRiskEvent.where('enrollment_id = ?', e.id).count > 0
          @at_risk_notified += 1
          a = AtRiskEvent.where('enrollment_id = ?', e.id).first
          if a.response_received?
            @at_risk_responded += 1
          else
            @at_risk_not_responded += 1
          end
        else
          @at_risk_not_notified += 1
        end
      end
    end
  end
  
  private
  
  def set_tab
    @tab = 'dashboard'
  end

end
