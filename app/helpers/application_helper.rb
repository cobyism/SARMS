module ApplicationHelper
  def current_class?(test_path)
    return 'current' if request.request_uri == test_path
    ''
  end

  def current_if_old(tab)
    section = @controller.controller_name
    if section == "activities" or section == "assessments" or section == "attendances" or section == "performances" or @unit
      section = "units"
    elsif section == "enrollments" or section == "faculty_assignments" or @user
         section = "users"
    end
    if current_user.is_student? || current_user.is_faculty?
      section = @controller.controller_name
      if current_user.id == tab && section != 'enrollments'
        return 'current'
      end
    end
    return 'current' if section == tab
    ''
  end
  
  def current_if(tab)
    return 'current' if tab == @tab
    ''
  end
  
  def current_if_scope(scope)
    return 'current' if params[:scope] == scope
    ''
  end
  
end
