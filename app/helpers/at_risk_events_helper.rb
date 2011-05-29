module AtRiskEventsHelper
  def has_been_notified(enrollment)
    return AtRiskEvent.where('enrollment_id = ?', enrollment.id).count > 0
  end
  
  def get_at_risk_event(enrollment)
    return AtRiskEvent.where('enrollment_id = ?', enrollment.id).first
  end
end
