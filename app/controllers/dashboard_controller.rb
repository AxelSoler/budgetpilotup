class DashboardController < ApplicationController
  def index
    scope = Current.user.transactions

    @transactions = scope.includes(:category).order(date: :desc).limit(10)

    @balance = scope.sum(:amount)
  end
end
