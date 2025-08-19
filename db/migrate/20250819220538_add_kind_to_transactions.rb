class AddKindToTransactions < ActiveRecord::Migration[8.0]
  def change
    add_column :transactions, :kind, :integer, default: 0, null: false
  end
end
