module AttendancesHelper
  def has_attended(enrollment, activity)
    return Attendance.where('enrollment_id = ? and activity_id = ?', enrollment.id, activity.id).count == 1
  end
  
  def attended_or_not(enrollment, activity)
    if has_attended(enrollment, activity)
      return "<span class='attended'>Attended</span>".html_safe
    else
      return "<span class='not_attended'>Not attended</span>".html_safe
    end
  end
  
  def get_attendance(enrollment, activity)
    return Attendance.where('enrollment_id = ? and activity_id = ?', enrollment.id, activity.id).first
  end
end
