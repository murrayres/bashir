require 'spec_helper'

app = AutomationFramework::Application.new

feature 'creates an external app and makes sure it is up and can be reached', sauce: false do
  let(:spaceinfo) do
    case app.env
    when 'DS1'
      { 'name': 'bashir',
        'internal': false,
        'stack':'ds1'
      }
    when 'DS2'
      { 'name': 'bashir',
        'internal': false,
        'stack':'ds2' 
      }
    when 'MARU'
    { 'name': 'bashir',
      'internal': false,
      'stack':'ds1' 
    }
    when 'LOCAL'
    { 'name': 'bashir',
      'internal': false,
      'stack':'ds1'
    }
    end
  end
  let(:appinfo) do
    case app.env
    when 'DS1'
      { 'appname': 'testapp',
        'appport': 80
      }
    when 'DS2'
      { 'appname': 'testapp',
        'appport': 80
      }
    when 'MARU'
    { 'appname': 'testapp',
      'appport': 80
    }
    when 'LOCAL'
    { 'appname': 'testapp',
      'appport': 80
    }
    end
  end
  let(:spaceappinfo) do
    case app.env
    when 'DS1'
      { 'appname': 'testapp',
        'space': 'bashir',
        'instances': 1,
        'plan':'scout'
      }
    when 'DS2'
      { 'appname': 'testapp',
        'space': 'bashir',
        'instances': 1,
        'plan':'scout'
      }
    when 'MARU'
    { 'appname': 'testapp',
      'space': 'bashir',
      'instances': 1,
      'plan':'scout'
    }
    when 'LOCAL'
    { 'appname': 'testapp',
      'space': 'bashir',
      'instances': 1,
      'plan':'scout'
    }
    end
  end
  let(:configsetinfo) do
    case app.env
    when 'DS1'
      { 'name': 'testapp-bashir',
        'type': 'app'
      }
    when 'DS2'
      { 'name': 'testapp-bashir',
        'type': 'app'
      }
    when 'MARU'
    { 'name': 'testapp-bashir',
      'type': 'app'
    }
    when 'LOCAL'
    { 'name': 'testapp-bashir',
      'type': 'app'
    }
    end
  end
  let(:configvarinfo) do
    case app.env
    when 'DS1'
      { 'setname': 'testapp-bashir',
        'varname': 'PORT',
        'varvalue': '80'
      }
    when 'DS2'
      { 'setname': 'testapp-bashir',
        'varname': 'PORT',
        'varvalue': '80'
      }
    when 'MARU'
    { 'setname': 'testapp-bashir',
      'varname': 'PORT',
      'varvalue': '80'
    }
    when 'LOCAL'
    { 'setname': 'testapp-bashir',
      'varname': 'PORT',
      'varvalue': '80'
    }
    end
  end
  let(:deployinfo) do
    case app.env
    when 'DS1'
      { 'appname': 'testapp',
        'space': 'bashir',
        'image': 'nginx:1.7.9'
      }
    when 'DS2'
      { 'appname': 'testapp',
        'space': 'bashir',
        'image': 'nginx:1.7.9'
      }
    when 'MARU'
    { 'appname': 'testapp',
      'space': 'bashir',
      'image': 'nginx:1.7.9'
    }
    when 'LOCAL'
    { 'appname': 'testapp',
      'space': 'bashir',
      'image': 'nginx:1.7.9'
    }
   end
  end
  let(:livecheckinfo) do
    case app.env
    when 'DS1'
      { 'url': 'https://testapp-bashir.alamoapp.octanner.io'}
    when 'DS2'
      { 'url': 'https://testapp-bashir.ds2app.octanner.io'}
    when 'MARU'
    { 'url': 'https://testapp-bashir.maruapp.octanner.io'}
    when 'LOCAL'
    { 'url': 'https://testapp-bashir.maruapp.octanner.io'}
    end
  end
  let(:appresponsebody) { app.regionapi.createapp(appinfo[:appname], appinfo[:appport]) } 
  let(:spaceappresponsebody) { app.regionapi.addapptospace(spaceappinfo[:appname], spaceappinfo[:space],spaceappinfo[:instances],spaceappinfo[:plan]) } 
  let(:configsetresponsebody) { app.regionapi.createconfigset(configsetinfo[:name], configsetinfo[:type]) } 
  let(:configvarresponsebody) { app.regionapi.addconfigvar(configvarinfo[:setname], configvarinfo[:varname],configvarinfo[:varvalue]) } 
  let(:deployresponsebody) { app.regionapi.deployapp(deployinfo[:appname], deployinfo[:space],deployinfo[:image]) } 


  scenario 'create an app and make sure it is up',
           type: 'contract', appserver: 'none', broken: false,
           development: true, staging: true, production: true do
    expect(JSON.parse(appresponsebody)).not_to be_empty
$stdout.puts "done createapp"
    expect(JSON.parse(spaceappresponsebody)).not_to be_empty
    expect(JSON.parse(configsetresponsebody)).not_to be_empty
    expect(JSON.parse(configvarresponsebody)).not_to be_empty
    expect(JSON.parse(deployresponsebody)).not_to be_empty
    sleep(5)
    livecode = 0
    $stdout.puts "Waiting for app to turn up ..."
    10.times do
    livecheckresponse= app.regionapi.livecheck(livecheckinfo[:url])
    $stdout.puts "status code : "+livecheckresponse.to_s
      if livecheckresponse == 200 then 
        livecode=livecheckresponse
        break
      end
      sleep 5
    end
      expect(livecode).to eq 200
  end
 



  before(:all) do
    $stdout.puts "running reset"
    case app.env
    when 'DS1'
      JSON.parse(app.regionapi.deleteconfigvar("testapp-bashir", "PORT"))
      JSON.parse(app.regionapi.deleteconfigset("testapp-bashir"))
      JSON.parse(app.regionapi.deleteappfromspace("testapp", "bashir"))
      JSON.parse(app.regionapi.deleteapp("testapp"))
      $stdout.puts "done with reset"
    when 'DS2'
      JSON.parse(app.regionapi.deleteconfigvar("testapp-bashir", "PORT"))
      JSON.parse(app.regionapi.deleteconfigset("testapp-bashir"))
      JSON.parse(app.regionapi.deleteappfromspace("testapp", "bashir"))
      JSON.parse(app.regionapi.deleteapp("testapp"))
      $stdout.puts "done with reset"
    when 'MARU'
      JSON.parse(app.regionapi.deleteconfigvar("testapp-bashir", "PORT"))
      JSON.parse(app.regionapi.deleteconfigset("testapp-bashir"))
      JSON.parse(app.regionapi.deleteappfromspace("testapp", "bashir"))
      JSON.parse(app.regionapi.deleteapp("testapp"))
      $stdout.puts "done with reset"
    when 'LOCAL'
      JSON.parse(app.regionapi.deleteconfigvar("testapp-bashir", "PORT"))
      JSON.parse(app.regionapi.deleteconfigset("testapp-bashir"))
      JSON.parse(app.regionapi.deleteappfromspace("testapp", "bashir"))
      JSON.parse(app.regionapi.deleteapp("testapp"))
      $stdout.puts "done with reset"
    end
  end


  after(:all) do
    $stdout.puts "running reset"
    case app.env
    when 'DS1'
      JSON.parse(app.regionapi.deleteconfigvar("testapp-bashir", "PORT"))
      JSON.parse(app.regionapi.deleteconfigset("testapp-bashir"))
      JSON.parse(app.regionapi.deleteappfromspace("testapp", "bashir"))
      JSON.parse(app.regionapi.deleteapp("testapp"))
      $stdout.puts "done with reset"
    when 'DS2'
      JSON.parse(app.regionapi.deleteconfigvar("testapp-bashir", "PORT"))
      JSON.parse(app.regionapi.deleteconfigset("testapp-bashir"))
      JSON.parse(app.regionapi.deleteappfromspace("testapp", "bashir"))
      JSON.parse(app.regionapi.deleteapp("testapp"))
      $stdout.puts "done with reset"
    when 'MARU'
      JSON.parse(app.regionapi.deleteconfigvar("testapp-bashir", "PORT"))
      JSON.parse(app.regionapi.deleteconfigset("testapp-bashir"))
      JSON.parse(app.regionapi.deleteappfromspace("testapp", "bashir"))
      JSON.parse(app.regionapi.deleteapp("testapp"))
      $stdout.puts "done with reset"
    when 'LOCAL'
      JSON.parse(app.regionapi.deleteconfigvar("testapp-bashir", "PORT"))
      JSON.parse(app.regionapi.deleteconfigset("testapp-bashir"))
      JSON.parse(app.regionapi.deleteappfromspace("testapp", "bashir"))
      JSON.parse(app.regionapi.deleteapp("testapp"))
      $stdout.puts "done with reset"
    end
   end




end
