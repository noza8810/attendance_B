require 'test_helper'

class StartpageControllerTest < ActionDispatch::IntegrationTest
  test "should get Top" do
    get startpage_Top_url
    assert_response :success
  end

end
