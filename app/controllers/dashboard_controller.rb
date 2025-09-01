class DashboardController < ApplicationController
  def index
    scope = Current.user.transactions

    @transactions = scope.includes(:category).order(date: :desc).limit(7)

    @balance = scope.sum(:amount)
  end
end
