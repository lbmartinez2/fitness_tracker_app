require "test_helper"

class ConsumptionControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get consumption_index_url
    assert_response :success
  end

  test "should get show" do
    get consumption_show_url
    assert_response :success
  end

  test "should get new" do
    get consumption_new_url
    assert_response :success
  end

  test "should get create" do
    get consumption_create_url
    assert_response :success
  end

  test "should get edit" do
    get consumption_edit_url
    assert_response :success
  end

  test "should get update" do
    get consumption_update_url
    assert_response :success
  end

  test "should get destroy" do
    get consumption_destroy_url
    assert_response :success
  end
end
