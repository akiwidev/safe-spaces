require 'test_helper'

class IncidentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get incidents_create_url
    assert_response :success
  end

  test "should get update" do
    get incidents_update_url
    assert_response :success
  end

  test "should get show" do
    get incidents_show_url
    assert_response :success
  end

end
