require 'spec_helper'

app = AutomationFramework::Application.new

feature 'creates an cassandra db and makes sure it can be reached', sauce: false do
  let(:provisionbody) { app.cassandraapi.provision("small","test") } 

  scenario 'provision, get url, access, delete',
           type: 'contract', appserver: 'none', broken: false,
           development: true, staging: true, production: false do
    cassandra_db = JSON.parse(provisionbody)["CASSANDRA_KEYSPACE"]
    $stdout.puts cassandra_db
    expect(cassandra_db).not_to be_empty

    geturlbody =  app.cassandraapi.geturl(cassandra_db)
    cassandra_db2 = JSON.parse(geturlbody)["CASSANDRA_KEYSPACE"]
    expect(cassandra_db2).to eq(cassandra_db)
 
#    showmeasurementsbody = app.cassandraapi.showmeasurements(JSON.parse(geturlbody)["INFLUX_DB"],JSON.parse(geturlbody)["INFLUX_URL"],JSON.parse(geturlbody)["INFLUX_USERNAME"],JSON.parse(geturlbody)["INFLUX_PASSWORD"] )
#    $stdout.puts showmeasurementsbody
#    expect(showmeasurementsbody).to eq("{\"results\":[{\"statement_id\":0}]}\n")


    deletebody = app.cassandraapi.deletedb(JSON.parse(geturlbody)["CASSANDRA_KEYSPACE"])
    $stdout.puts deletebody
    expect(deletebody).to eq("null")

   end
end
