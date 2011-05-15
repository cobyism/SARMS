require 'test_helper'

class FacultyAssignmentsControllerTest < ActionController::TestCase
  setup do
    @faculty_assignment = faculty_assignments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:faculty_assignments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create faculty_assignment" do
    assert_difference('FacultyAssignment.count') do
      post :create, :faculty_assignment => @faculty_assignment.attributes
    end

    assert_redirected_to faculty_assignment_path(assigns(:faculty_assignment))
  end

  test "should show faculty_assignment" do
    get :show, :id => @faculty_assignment.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @faculty_assignment.to_param
    assert_response :success
  end

  test "should update faculty_assignment" do
    put :update, :id => @faculty_assignment.to_param, :faculty_assignment => @faculty_assignment.attributes
    assert_redirected_to faculty_assignment_path(assigns(:faculty_assignment))
  end

  test "should destroy faculty_assignment" do
    assert_difference('FacultyAssignment.count', -1) do
      delete :destroy, :id => @faculty_assignment.to_param
    end

    assert_redirected_to faculty_assignments_path
  end
end
