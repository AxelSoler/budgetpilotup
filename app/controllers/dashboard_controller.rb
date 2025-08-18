class DashboardController < ApplicationController

  def index
    @transactions = Current.user.transactions.includes(:category).order(date: :desc).limit(5)
    @balance = @transactions.sum(:amount)
  end
end
