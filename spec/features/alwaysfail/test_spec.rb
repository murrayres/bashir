require 'spec_helper'

app = AutomationFramework::Application.new

feature 'runs a test that always fails', sauce: false do

   scenario 'expect 1 to equal 0',
           type: 'contract', appserver: 'none', broken: false,
           development: true, staging: true, production: true do
    expect("1").to eq("0")

   end
end
