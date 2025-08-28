require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    post session_url, params: { email_address: @user.email_address, password: "password" }
    @category = categories(:one)
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should create category" do
    assert_difference("Category.count") do
      post categories_url, params: { category: { name: "New Category" } }
    end

    assert_redirected_to categories_url
  end

  test "should update category" do
    patch category_url(@category), params: { category: { name: "Updated Category" } }
    assert_redirected_to categories_url
    @category.reload
    assert_equal "Updated Category", @category.name
  end

  test "should destroy category" do
    category_to_destroy = @user.categories.create(name: "To be destroyed")
    assert_difference("Category.count", -1) do
      delete category_url(category_to_destroy)
    end

    assert_redirected_to categories_url
  end

  test "should not destroy category with transactions" do
    assert_no_difference("Category.count") do
      delete category_url(@category)
    end

    assert_redirected_to categories_url
    assert_not_nil flash[:alert]
  end
end
