require "test_helper"

class StatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    post session_url, params: { email_address: @user.email_address, password: "password" }
  end

  test "should get index and render charts" do
    get stats_url
    assert_response :success

    assert_select "h1", "Stats"
    assert_select "h3", "Balance Over Time"
    assert_select "h3", "Income vs Expenses"
    assert_select "h3", "Expenses by Category"
  end
end
