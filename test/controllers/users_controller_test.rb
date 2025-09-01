require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { email_address: "test@example.com", password: "password", password_confirmation: "password" } }
    end

    assert_redirected_to new_session_url
  end

  test "should not create user with invalid password confirmation" do
    assert_no_difference("User.count") do
      post users_url, params: { user: { email_address: "test2@example.com", password: "password", password_confirmation: "wrong" } }
    end

    assert_response :unprocessable_entity
  end
end
