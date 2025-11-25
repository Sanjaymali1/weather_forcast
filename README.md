# Weather Forecast App

A Ruby on Rails application to fetch weather forecasts for a given address. The app demonstrates service objects, caching, value objects, and proper testing practices.

---

## Development

### Requirements

* Ruby Version Manager ([RVM](https://rvm.io))
* Ruby 3.2.3
* Rails 8.1.1
* SQLite3 (development)
* Bundler
* HTTParty gem (for API calls)

### Setup

# Clone the repository
git clone https://github.com/Sanjaymali1/weather_forcast.git
cd weather_forcast

# Install dependencies
bundle install

# Create and migrate the database
rails db:create
rails db:migrate
rails db:seed

# Run the test suite
bundle exec rspec

# Start the Rails server
rails server
