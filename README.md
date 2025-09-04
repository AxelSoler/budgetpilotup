# Budget Pilot

[![CI](https://github.com/axelss/budgetpilotup/actions/workflows/ci.yml/badge.svg)](https://github.com/axelss/budgetpilotup/actions/workflows/ci.yml)

Budget Pilot is a modern personal finance management application designed to help you track your income and expenses with ease. It features a clean, responsive interface and powerful tools, including AI-powered receipt analysis to automate transaction entry.

## ✨ Key Features

- **Secure User Authentication**: Standard sign-up, login, and password recovery.
- **Transaction Management**: Easily create, view, and manage income and expense records.
- **Categorization**: Organize transactions into custom categories for better insights.
- **Interactive Dashboard**: A central hub to view recent activity and a summary of your financial health.
- **Visual Stats**: Charts and graphs to visualize your spending patterns over time.
- **AI-Powered Categorization**: Upload a receipt (image or PDF), and let AI automatically extract the details (title, amount, description, and category) to fill out the form for you.
- **PWA Ready**: Can be "installed" on mobile devices for a native-like experience.

## 🛠️ Tech Stack

- **Backend**: Ruby on Rails 7
- **Frontend**: Hotwire (Turbo, Stimulus), Tailwind CSS, Rails Charts
- **Database**: SQLite3 (development), PostgreSQL (production)
- **AI Integration**: Google Gemini API for receipt analysis
- **Deployment**: Docker & Kamal
- **Testing**: Minitest with SimpleCov for code coverage
- **CI/CD**: GitHub Actions

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

- Ruby (see `.ruby-version` for details)
- Node.js
- Yarn
- PostgreSQL

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/axelss/budgetpilotup.git
    cd budgetpilotup
    ```

2.  **Install dependencies:**
    ```bash
    bundle install
    yarn install
    ```

3.  **Set up environment variables:**
    Create a `.env` file in the root of the project and add the necessary environment variables. At a minimum, you will need the Gemini API key.
    ```
    GEMINI_API_KEY=tu_api_key_aqui
    ```
    *This project uses the `dotenv-rails` gem to manage environment variables in development.*

4.  **Set up the database:**
    ```bash
    rails db:create
    rails db:migrate
    rails db:seed # Optional, to populate with initial data
    ```

5.  **Run the development server:**
    ```bash
    ./bin/dev
    ```
    The application will be available at `http://localhost:3000`.

## ✅ Running Tests

To run the full test suite and generate a coverage report, use:

```bash
rails test
```

Coverage reports are generated in the `coverage/` directory.

## 🚢 Deployment

This application is configured for deployment using [Kamal](https://kamal-deploy.org/). The configuration can be found in `config/deploy.yml`. The deployment process is containerized using Docker (`Dockerfile`).

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/axelss/budgetpilotup/issues).

## 📄 License

This project is unlicensed. Consider adding an open-source license like [MIT](https://opensource.org/licenses/MIT).