class DashboardController < ApplicationController

  def index
    @transactions = Current.user.transactions.includes(:category).order(date: :desc)
    @balance = @transactions.sum(:amount)
  end
end
