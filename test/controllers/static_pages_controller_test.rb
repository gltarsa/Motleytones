require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get bios" do
    get :bios
    assert_response :success
  end

  test "should get schedule" do
    get :schedule
    assert_response :success
  end

  test "should get photos" do
    get :photos
    assert_response :success
  end

  test "should get videos" do
    get :videos
    assert_response :success
  end

end
