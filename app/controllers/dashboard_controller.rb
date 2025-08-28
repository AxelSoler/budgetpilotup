class DashboardController < ApplicationController
  def index
    scope = Current.user.transactions

    @transactions = scope.includes(:category).order(date: :desc).limit(10)

    @balance = scope.sum(:amount)

    @balance_over_time = scope.group(:date).sum(:amount)

    @kind_split = {
      "Income"   => scope.income.sum(:amount),
      "Expenses" => -scope.expense.sum(:amount)
    }

    @expenses_by_category = scope.expense
                                 .joins(:category)
                                 .group("categories.name")
                                 .sum(Arel.sql("ABS(transactions.amount)"))
  end
end
