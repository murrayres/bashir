require 'spec_helper'

app = AutomationFramework::Application.new

feature 'creates an influx db and makes sure it can be reached', sauce: false do
  let(:provisionbody) { app.influxapi.provision("shared","test") } 

  scenario 'provision, get url, access, delete',
           type: 'contract', appserver: 'none', broken: false,
           development: true, staging: true, production: true do
    influx_db = JSON.parse(provisionbody)["INFLUX_DB"]
    $stdout.puts influx_db
    expect(influx_db).not_to be_empty

    geturlbody =  app.influxapi.geturl(influx_db)
    influx_db2 = JSON.parse(geturlbody)["INFLUX_DB"]
    expect(influx_db2).to eq(influx_db)
 
    showmeasurementsbody = app.influxapi.showmeasurements(JSON.parse(geturlbody)["INFLUX_DB"],JSON.parse(geturlbody)["INFLUX_URL"],JSON.parse(geturlbody)["INFLUX_USERNAME"],JSON.parse(geturlbody)["INFLUX_PASSWORD"] )
    $stdout.puts showmeasurementsbody
    expect(showmeasurementsbody).to eq("{\"results\":[{\"statement_id\":0}]}\n")


    deletebody = app.influxapi.deletedb(JSON.parse(geturlbody)["INFLUX_DB"])
    $stdout.puts deletebody
    expect(deletebody).to eq("{\"message\":\"deleted\"}")

   end
end
