# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "🌱 Seeding database..."

# --- Create a sample user ---
puts "Creating sample user..."
user = User.find_or_create_by!(email_address: "user@example.com") do |u|
  u.password = "password"
  u.password_confirmation = "password"
end
puts "Sample user found or created: user@example.com / password"

# --- Create default categories for the user ---
puts "Creating default categories for user: #{user.email_address}..."
user.categories.destroy_all # Start with a clean slate for this user

categories_data = [
  { name: "Food & Dining" },
  { name: "Transportation" },
  { name: "Housing" },
  { name: "Utilities" },
  { name: "Health & Wellness" },
  { name: "Entertainment" },
  { name: "Shopping" },
  { name: "Salary" },
  { name: "Freelance" },
  { name: "Other" }
]

categories = categories_data.map do |category_attrs|
  user.categories.find_or_create_by!(name: category_attrs[:name])
end
puts "#{categories.count} categories created for #{user.email_address}."

# --- Create sample transactions for the user ---
puts "Creating sample transactions for user: #{user.email_address}..."
user.transactions.destroy_all # Start with a clean slate for this user

# Map category names to objects for easy lookup
category_map = categories.index_by(&:name)

# --- Income Transactions ---
income_transactions = []
if category_map["Salary"]
  income_transactions << {
    user: user, title: "Monthly Salary", kind: :income, amount: 3000,
    date: 1.month.ago.beginning_of_month + 5.days, category: category_map["Salary"],
    description: "August salary"
  }
  income_transactions << {
    user: user, title: "Monthly Salary", kind: :income, amount: 3000,
    date: Time.current.beginning_of_month + 5.days, category: category_map["Salary"],
    description: "September salary"
  }
end

if category_map["Freelance"]
  income_transactions << {
    user: user, title: "Web Design Project", kind: :income, amount: 850,
    date: 1.month.ago.beginning_of_month + 20.days, category: category_map["Freelance"],
    description: "Logo and website for Client X"
  }
end
Transaction.create!(income_transactions) if income_transactions.any?

# --- Expense Transactions ---
expense_transactions = [
  # Last Month
  { user: user, title: "Supermarket", kind: :expense, amount: 125.50, date: 35.days.ago, category: category_map["Food & Dining"] },
  { user: user, title: "Gasoline", kind: :expense, amount: 50.00, date: 32.days.ago, category: category_map["Transportation"] },
  { user: user, title: "Rent Payment", kind: :expense, amount: 1200.00, date: 30.days.ago.beginning_of_month, category: category_map["Housing"] },
  { user: user, title: "Electricity Bill", kind: :expense, amount: 75.80, date: 25.days.ago, category: category_map["Utilities"] },
  { user: user, title: "Movie Night", kind: :expense, amount: 45.00, date: 22.days.ago, category: category_map["Entertainment"] },
  { user: user, title: "New T-shirt", kind: :expense, amount: 29.99, date: 20.days.ago, category: category_map["Shopping"] },
  { user: user, title: "Pharmacy", kind: :expense, amount: 15.20, date: 18.days.ago, category: category_map["Health & Wellness"] },

  # Current Month
  { user: user, title: "Weekly Groceries", kind: :expense, amount: 98.75, date: 7.days.ago, category: category_map["Food & Dining"] },
  { user: user, title: "Bus Pass", kind: :expense, amount: 60.00, date: 6.days.ago, category: category_map["Transportation"] },
  { user: user, title: "Internet Bill", kind: :expense, amount: 55.00, date: 5.days.ago, category: category_map["Utilities"] },
  { user: user, title: "Dinner with Friends", kind: :expense, amount: 88.20, date: 3.days.ago, category: category_map["Food & Dining"] },
  { user: user, title: "Gym Membership", kind: :expense, amount: 40.00, date: 2.days.ago, category: category_map["Health & Wellness"] },
  { user: user, title: "Coffee Shop", kind: :expense, amount: 5.50, date: 1.day.ago, category: category_map["Food & Dining"] }
].compact # Use compact to remove nil entries if a category is missing

Transaction.create!(expense_transactions) if expense_transactions.any?

puts "Sample transactions created: #{Transaction.count}"

puts "✅ Seeding finished."
