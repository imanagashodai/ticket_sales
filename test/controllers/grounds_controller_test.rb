require 'test_helper'

class GroundsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get grounds_new_url
    assert_response :success
  end

end
