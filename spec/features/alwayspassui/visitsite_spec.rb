require 'spec_helper'
require "selenium/webdriver"
require 'capybara'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'

app = AutomationFramework::Application.new

feature 'runs a test that always passes', sauce: false do

   scenario 'expect response code to be 200',
           type: 'contract', appserver: 'none', broken: false,
           development: true, staging: true, production: true do


      Capybara.default_driver = :chrome
        Capybara.register_driver :selenium_chrome do |app|
              browser_options = ::Selenium::WebDriver::Chrome::Options.new
                puts "Is running headless in docker!"
                browser_options.args << '--headless'
                browser_options.args << '--disable-gpu'
                browser_options.args << '--window-size=1980,1980'
                browser_options.args << '--auto-open-devtools-for-tabs'
                browser_options.args << '--disable-dev-shm-usage'
                browser_options.args << '--no-sandbox'
                Capybara::Selenium::Driver.new(app, :browser => :chrome, options: browser_options)

        end
        Capybara.current_driver = :selenium_chrome

      Capybara::Screenshot.autosave_on_failure = true
      Capybara::Screenshot.prune_strategy = :keep_last_run

      visit 'https://appsignal.com'
      page.save_screenshot("./test-results/ss.png")
end
end

