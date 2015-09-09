require 'test_helper'

class MainControllerTest < ActionController::TestCase
  test "should get hud" do
    get :hud
    assert_response :success
  end

end
