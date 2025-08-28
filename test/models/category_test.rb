require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  setup do
    @category = categories(:one)
  end

  test "should not save category without name" do
    category = Category.new
    assert_not category.save
  end

  test "should not destroy category with transactions" do
    assert_not @category.destroy
  end
end
