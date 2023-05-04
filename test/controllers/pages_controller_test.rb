require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get pages_login_url
    assert_response :success
  end
end
