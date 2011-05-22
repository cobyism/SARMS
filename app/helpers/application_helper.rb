module ApplicationHelper
  def current_class?(test_path)
    return 'current' if request.request_uri == test_path
    ''
  end

  def current_if(tab)
    return 'current' if @controller.controller_name == tab
    ''
  end
end
