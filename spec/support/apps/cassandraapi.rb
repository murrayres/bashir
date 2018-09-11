class Cassandraapi < AutomationFramework::Utilities
    include CallServices
    def provision(plan, billingcode)
        uri = '/v1/service/cassandra/instance'
        headers = {}
        $stdout.puts ENV['APP_URL']
        payload={:plan => plan,:billingcode => billingcode }
        $stdout.puts payload.to_json.to_s
        response = Faraday.new(ENV['APP_URL']).post uri, payload.to_json, headers
        $stdout.puts response.body.to_s
        expect(response.status).to eq 201
        response.body
    end

    def geturl(name)
        uri = '/v1/service/cassandra/url/'+name
        headers = {}
        $stdout.puts ENV['APP_URL']+uri
        response = Faraday.new(ENV['APP_URL']).get uri, {}, headers
        $stdout.puts response.body.to_s
        expect(response.status).to eq 200
        return response.body
    end



    def deletedb(db)
        uri = '/v1/service/cassandra/instance/'+db
        headers = {}
        $stdout.puts ENV['APP_URL']
        response = Faraday.new(ENV['APP_URL']).delete uri, {}, headers
        $stdout.puts response.body.to_s
        expect(response.status).to eq 200
        response.body
    end

  end

  
