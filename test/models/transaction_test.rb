require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @category = categories(:one)
  end

  test "should not save transaction without amount" do
    transaction = Transaction.new(user: @user, category: @category, kind: :expense, title: "test")
    assert_not transaction.save
  end

  test "should not save transaction with amount less than or equal to zero" do
    transaction = Transaction.new(user: @user, category: @category, kind: :expense, amount: 0, title: "test")
    assert_not transaction.save
  end

  test "should default kind to income" do
    transaction = Transaction.new(user: @user, category: @category, amount: 10, title: "test")
    transaction.save
    assert_equal "income", transaction.kind
  end

  test "should set date on create" do
    transaction = Transaction.new(user: @user, category: @category, amount: 10, kind: :expense, title: "test")
    transaction.save
    assert_equal Date.today, transaction.date
  end

  test "should apply sign to amount for expense" do
    transaction = Transaction.new(user: @user, category: @category, amount: 10, kind: :expense, title: "test")
    transaction.save
    assert_equal -10, transaction.amount
  end

  test "should not apply sign to amount for income" do
    transaction = Transaction.new(user: @user, category: @category, amount: 10, kind: :income, title: "test")
    transaction.save
    assert_equal 10, transaction.amount
  end
end
