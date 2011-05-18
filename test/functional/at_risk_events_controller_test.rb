require 'test_helper'

class AtRiskEventsControllerTest < ActionController::TestCase
  setup do
    @at_risk_event = at_risk_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:at_risk_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create at_risk_event" do
    assert_difference('AtRiskEvent.count') do
      post :create, :at_risk_event => @at_risk_event.attributes
    end

    assert_redirected_to at_risk_event_path(assigns(:at_risk_event))
  end

  test "should show at_risk_event" do
    get :show, :id => @at_risk_event.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @at_risk_event.to_param
    assert_response :success
  end

  test "should update at_risk_event" do
    put :update, :id => @at_risk_event.to_param, :at_risk_event => @at_risk_event.attributes
    assert_redirected_to at_risk_event_path(assigns(:at_risk_event))
  end

  test "should destroy at_risk_event" do
    assert_difference('AtRiskEvent.count', -1) do
      delete :destroy, :id => @at_risk_event.to_param
    end

    assert_redirected_to at_risk_events_path
  end
end
