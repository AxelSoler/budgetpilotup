class Transaction < ApplicationRecord
  belongs_to :category
  belongs_to :user

  before_validation :set_date, on: :create

  private

  def set_date
    self.date ||= Date.today
  end
end
