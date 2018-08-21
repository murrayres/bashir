class Regionapi < AutomationFramework::Utilities
    include CallServices
    def createspace(name, internal, stack)
        uri = '/v1/space'
        headers = {}
        $stdout.puts ENV['APP_URL']
        payload={:name => name,:internal => internal,:stack=>stack }
        $stdout.puts payload.to_json.to_s
        response = Faraday.new(ENV['APP_URL']).post uri, payload.to_json, headers
        $stdout.puts response.body.to_s
        expect(response.status).to eq 201
        response.body
    end
    def createapp(appname, appport)
        uri = '/v1/app'
        headers = {}
        $stdout.puts ENV['APP_URL']
        payload={:appname => appname,:appport => appport }
        $stdout.puts payload.to_json.to_s
        response = Faraday.new(ENV['APP_URL']).post uri, payload.to_json, headers
        $stdout.puts response.body.to_s
        expect(response.status).to eq 201
        response.body
    end
    def addapptospace(appname, space, instances, plan)
        uri = '/v1/space/'+space+'/app/'+appname
        headers = {}
        $stdout.puts ENV['APP_URL']
        payload={:appname => appname,:space => space,:instances=>instances,:plan=>plan }
        $stdout.puts payload.to_json.to_s
        response = Faraday.new(ENV['APP_URL']).put uri, payload.to_json, headers
        $stdout.puts response.body.to_s
        expect(response.status).to eq 201
        response.body
    end
    def createconfigset(name, type)
        uri = '/v1/config/set'
        headers = {}
        $stdout.puts ENV['APP_URL']
        payload={:name => name,:type => type}
        $stdout.puts payload.to_json.to_s
        response = Faraday.new(ENV['APP_URL']).post uri, payload.to_json, headers
        $stdout.puts response.body.to_s
        expect(response.status).to eq 201
        response.body
    end
    def addconfigvar(setname, varname, varvalue)
        uri = '/v1/config/set/configvar'
        headers = {}
        $stdout.puts ENV['APP_URL']
        payload={:setname => setname,:varname => varname,:varvalue=>varvalue}
        payloadarray =[]
        payloadarray << payload
        $stdout.puts payload.to_json.to_s
        response = Faraday.new(ENV['APP_URL']).post uri, payloadarray.to_json, headers
        $stdout.puts response.body.to_s
        expect(response.status).to eq 201
        response.body
    end
    def deployapp(appname, space, appimage)
        uri = '/v1/app/deploy'
        headers = {}
        $stdout.puts ENV['APP_URL']
        payload={:appname => appname,:space => space,:appimage=>appimage}
        $stdout.puts payload.to_json.to_s
        response = Faraday.new(ENV['APP_URL']).post uri, payload.to_json, headers
        $stdout.puts response.body.to_s
        expect(response.status).to eq 201
        response.body
    end
    def livecheck(url)
        uri = '/'
        headers = {}
        $stdout.puts url
        begin
          response = Faraday.new(url).get uri, {}, headers
          return response.status
        rescue Faraday::Error::ConnectionFailed => e
          return 0
        end  
        return 0
    end
  end

  