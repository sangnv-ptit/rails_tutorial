source "https://rubygems.org"

gem "rails", "5.1.4"
gem "sass-rails", "5.0.6"
gem "coffee-rails", "4.2.2"
gem "jquery-rails", "4.3.1"
gem "turbolinks", "5.0.1"
gem "bootstrap-sass", "3.3.7"

group :development, :test do
  gem "sqlite3", "1.3.13"
  gem "byebug", "9.0.6", platform: :mri
  gem "selenium-webdriver"
  gem "rspec"
  gem "rspec-rails"
  gem "rspec-collection_matchers"
  gem "better_errors"
  gem "guard-rspec", require: false
  gem "database_cleaner"
  gem "brakeman", require: false
  gem "jshint"
  gem "bundler-audit"
  gem "rubocop", "~> 0.35.0", require: false
  gem "rubocop-checkstyle_formatter", require: false
  gem "scss_lint_reporter_checkstyle", require: false
  gem "rails_best_practices"
  gem "reek"
  gem "railroady"
  gem "autoprefixer-rails"
  gem "factory_bot_rails"
  gem "eslint-rails", git: "https://github.com/octoberstorm/eslint-rails", require: false
end

group :development do
  gem "web-console", "3.5.1"
  gem "listen", "3.0.8"
  gem "spring", "2.0.2"
  gem "spring-watcher-listen", "2.0.1"
end

group :test do
  gem "rails-controller-testing", "1.0.2"
  gem "minitest-reporters", "1.1.14"
  gem "guard", "2.13.0"
  gem "guard-minitest", "2.4.4"
  gem "simplecov", require: false
  gem "simplecov-rcov", require: false
  gem "simplecov-json"
  gem "shoulda-matchers"
end

group :production do
  gem "pg", "0.18.4"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
