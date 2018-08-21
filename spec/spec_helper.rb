require File.expand_path('../../config/environment', __FILE__)
require 'capybara'
require 'capybara/rspec'
require 'csv'
require 'dotenv'
require 'support/utilities'
require 'support/application'
require 'rspec/expectations'
require 'require_all'
require 'net/https'
require 'pry'
require 'json'
require 'colorize'
require 'rspec/retry'
require 'oauth2'
require 'rspec'
require 'mailinator'
require 'rest-client'
require 'json-compare'
require 'mongo'
require 'timeout'
include RSpec::Core::Pending
require_rel '/support/apps/'

# rubocop:disable Style/GlobalVars
$config = YAML.load_file('spec/support/config.yml') if File.exist?('spec/support/config.yml')

# rubocop:disable Style/ConditionalAssignment
if ENV['APP_ENV'].nil? && $config
  app_env = $config['env'].upcase
elsif ENV['APP_ENV'].nil? == false
  app_env = ENV['APP_ENV'].upcase
else
  app_env = 'MARU'
end
# rubocop:enable Style/ConditionalAssignment

dotenv_files = ["./config/environments/.env.#{app_env}.local",
                './config/environments/.env.local',
                "./config/environments/.env.#{app_env}",
                './config/environments/.env']
Dotenv.load(*dotenv_files.map(&:downcase))

Capybara.configure do |config|
  config.run_server = true
  config.default_max_wait_time = 15
  config.match = :prefer_exact
  config.ignore_hidden_elements = true
  config.visible_text_only = true
  config.automatic_reload = true
  config.default_driver = :selenium
end

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers
  config.formatter = :documentation
  config.verbose_retry = true
  config.display_try_failure_messages = true
  config.default_retry_count = 2
  config.default_sleep_interval = 2
  config.filter_run_excluding broken: true
  case app_env
  when
    'DS1' then config.filter_run_excluding production: false
  when
    'DS2' then config.filter_run_excluding staging: false
  when
    'MARU' then config.filter_run_excluding development: false
  end

  config.expect_with :rspec do |c|
    c.syntax = %i[should expect]
  end

  
  # rubocop:enable Style/GlobalVars, Lint/ShadowingOuterLocalVariable
end
