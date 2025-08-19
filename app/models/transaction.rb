class Transaction < ApplicationRecord
  belongs_to :category
  belongs_to :user

  enum :kind, { income: 0, expense: 1 }

  validates :amount, numericality: { greater_than: 0 }
  validates :kind, presence: true

  before_validation :set_date, on: :create
  before_save :apply_sign_to_amount

  private

  def set_date
    self.date ||= Date.today
  end

  # Ensure that expenses are stored as negative amounts
  def apply_sign_to_amount
    if expense? && amount.positive?
      self.amount = -amount
    end
  end
end
