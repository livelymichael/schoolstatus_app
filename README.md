# Person Data Integration Project

## Overview
This Ruby on Rails project integrates with public APIs to fetch additional data for a list of persons and processes information from a CSV file. The project aims to display a list of names and addresses, and when a user selects an individual, additional information about that person is retrieved from public APIs.

## Core Features
- Read data from a CSV file containing names and addresses.
- Fetch additional data from public APIs (e.g., Census API).
- Display a list of persons and show detailed information for a selected person.
- Handle and log errors during CSV processing and API integration.

## Technologies Used
- Ruby on Rails
- RSpec for testing
- FactoryBot and Faker for test data generation
- CSV for reading CSV files
- Faraday for HTTP requests
- Logger for error logging

## Getting Started
To set up the project, follow these steps:

### Prerequisites
- Ruby 3.2.1 or later
- Rails 7.1.3 or later
- PostgreSQL

### Installation
1. Clone the repository:
- `git clone https://github.com/livelymichael/schoolstatus_app`
- `cd schoolstatus_app`

2. Install the required gems:
- `bundle install`

3. Set up the database:
- `rails db:create`
- `rails db:migrate`


### Configuration
- Ensure your database configuration is set correctly in `config/database.yml`.
- Modify any additional configuration files if needed (e.g., `config/application.rb`).

## Running the Application
To run the Rails server, use the following command:
- `rails server`
The application will be available at `http://localhost:3000`.

## Running Tests
To run the test suite, ensure you have RSpec installed:
- `bundle exec rspec`

This will run all RSpec tests in the project. Ensure all tests pass before deploying or making significant changes.

## Logging and Error Handling
The project uses a custom `CSVReader` module to read CSV files and log errors. If an error occurs during CSV processing, the error is logged, and the system does not crash. Ensure your logger is configured correctly in the project.

## Additional Information
- **Custom Extensions**: If you create custom extensions of the `CSVReader`, ensure the `process_row` method is implemented correctly to avoid `NotImplementedError`.
- **Public API Integration**: When integrating with public APIs, handle errors and exceptions gracefully to avoid disrupting the application flow.

## Contribution Guidelines
If you'd like to contribute to this project, please follow these guidelines:

- Fork the repository and create a new branch for your feature or bug fix.
- Write clear and detailed commit messages.
- Run all tests to ensure nothing is broken.
- Submit a pull request with a detailed explanation of your changes.

## License
This project is licensed under the [MIT License](LICENSE)

## Contact Information
If you have any questions or need additional information, please open an issue on GitHub.



