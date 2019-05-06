require 'spec_helper'

app = AutomationFramework::Application.new

feature 'runs a test that always passes', sauce: false do

   scenario 'expect 1 to equal 1',
           type: 'contract', appserver: 'none', broken: false,
           development: true, staging: true, production: true do
    expect("1").to eq("1")

   end
end
