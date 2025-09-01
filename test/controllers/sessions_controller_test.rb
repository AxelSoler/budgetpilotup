require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get new" do
    get new_session_url
    assert_response :success
  end

  test "should create session" do
    post session_url, params: { email_address: @user.email_address, password: "password" }
    assert_redirected_to dashboard_url
  end

  test "should not create session with invalid credentials" do
    post session_url, params: { email_address: @user.email_address, password: "wrong_password" }
    assert_redirected_to new_session_url
  end

  test "should destroy session" do
    # First, log in
    post session_url, params: { email_address: @user.email_address, password: "password" }
    assert_redirected_to dashboard_url

    # Then, log out
    delete session_url
    assert_redirected_to new_session_url
  end
end
