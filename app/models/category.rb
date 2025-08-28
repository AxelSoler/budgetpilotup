class Category < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  has_many :transactions

  before_destroy :check_for_transactions

  private

  def check_for_transactions
    if transactions.any?
      errors.add(:base, "Cannot delete a category with transactions.")
      throw :abort
    end
  end
end
