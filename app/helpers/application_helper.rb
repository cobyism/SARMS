module ApplicationHelper
  def current_class?(test_path)
    return 'current' if request.request_uri == test_path
    ''
  end

  def current_if(tab)
    section = @controller.controller_name
    if section == "activities" or section == "assessments" or section == "attendances" or section == "performances"
      section = "units"
    end
    return 'current' if section == tab
    ''
  end
  def current_if_scope(scope)
    return 'current' if params[:scope] == scope
    ''
  end
end
