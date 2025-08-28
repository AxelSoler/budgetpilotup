require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "password reset token with signed_id" do
    user = users(:one)
    token = user.signed_id(purpose: "password_reset", expires_in: 15.minutes)
    found_user = User.find_signed(token, purpose: "password_reset")
    assert_equal user, found_user
  end

  test "password_reset_token method" do
    user = users(:one)
    assert_respond_to user, :password_reset_token
    token = user.password_reset_token
    found_user = User.find_by_password_reset_token(token)
    assert_equal user, found_user
  end
end
