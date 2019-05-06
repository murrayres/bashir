require 'spec_helper'

app = AutomationFramework::Application.new
appname = ENV['APPNAME']
spacename = ENV['SPACENAME']
image = ENV['IMAGE']
port = ENV['PORT'].to_i
internalenv = ENV['INTERNAL']
internal = false
if internalenv == 'true' then
    internal=true
end
if internalenv == 'false' then
    internal=false
end
feature 'creates an external app and makes sure it is up and can be reached', sauce: false do
  let(:spaceinfo) do
    case app.env
    when 'DS1'
      { 'name': spacename,
        'internal': internal,
        'stack':'ds1'
      }
    when 'DS2'
      { 'name': spacename,
        'internal': internal,
        'stack':'ds2' 
      }
    when 'DS3'
      { 'name': spacename,
        'internal': internal,
        'stack':'ds3'
      }
    when 'BS1'
      { 'name': spacename,
        'internal': internal,
        'stack':'bs1'
      }
    when 'MARU'
    { 'name': spacename,
      'internal': internal,
      'stack':'ds1' 
    }
    when 'LOCAL'
    { 'name': spacename,
      'internal': internal,
      'stack':'ds1'
    }
    end
  end
  let(:appinfo) do
    case app.env
    when 'DS1'
      { 'appname': appname,
        'appport': port
      }
    when 'DS2'
      { 'appname': appname,
        'appport': port
      }
    when 'DS3'
      { 'appname': appname,
        'appport': port
      }
    when 'BS1'
      { 'appname': appname,
        'appport': port
      }  
    when 'MARU'
    { 'appname': appname,
      'appport': port
    }
    when 'LOCAL'
    { 'appname': appname,
      'appport': port
    }
    end
  end
  let(:spaceappinfo) do
    case app.env
    when 'DS1'
      { 'appname': appname,
        'space': spacename,
        'instances': 1,
        'plan':'gp1'
      }
    when 'DS2'
      { 'appname': appname,
        'space': spacename,
        'instances': 1,
        'plan':'gp1'
      }
    when 'DS3'
      { 'appname': appname,
        'space': spacename,
        'instances': 1,
        'plan':'gp1'
      }
    when 'BS1'
      { 'appname': appname,
        'space': spacename,
        'instances': 1,
        'plan':'gp1'
      }
    when 'MARU'
    { 'appname': appname,
      'space': spacename,
      'instances': 1,
      'plan':'gp1'
    }
    when 'LOCAL'
    { 'appname': appname,
      'space': spacename,
      'instances': 1,
      'plan':'gp1'
    }
    end
  end
  let(:configsetinfo) do
    case app.env
    when 'DS1'
      { 'name': appname+'-'+spacename,
        'type': 'app'
      }
    when 'DS2'
      { 'name': appname+'-'+spacename,
        'type': 'app'
      }
    when 'DS3'
      { 'name': appname+'-'+spacename,
        'type': 'app'
      }
    when 'BS1'
      { 'name': appname+'-'+spacename,
        'type': 'app'
      }
    when 'MARU'
    { 'name': appname+'-'+spacename,
      'type': 'app'
    }
    when 'LOCAL'
    { 'name': appname+'-'+spacename,
      'type': 'app'
    }
    end
  end
  let(:configvarinfo) do
    case app.env
    when 'DS1'
      { 'setname': appname+'-'+spacename,
        'varname': 'PORT',
        'varvalue': port.to_s
      }
    when 'DS2'
      { 'setname': appname+'-'+spacename,
        'varname': 'PORT',
        'varvalue': port.to_s
      }
    when 'DS3'
      { 'setname': appname+'-'+spacename,
        'varname': 'PORT',
        'varvalue': port.to_s
      }
    when 'DS3'
      { 'setname': appname+'-'+spacename,
        'varname': 'PORT',
        'varvalue': port.to_s
      }
    when 'BS1'
      { 'setname': appname+'-'+spacename,
        'varname': 'PORT',
        'varvalue': port.to_s
      }
    when 'MARU'
    { 'setname': appname+'-'+spacename,
      'varname': 'PORT',
      'varvalue': port.to_s
    }
    when 'LOCAL'
    { 'setname': appname+'-'+spacename,
      'varname': 'PORT',
      'varvalue': port.to_s
    }
    end
  end
  let(:deployinfo) do
    case app.env
    when 'DS1'
      { 'appname': appname,
        'space': spacename,
        'image': image,
        'port': port
      }
    when 'DS2'
      { 'appname': appname,
        'space': spacename,
        'image': image,
        'port': port
      }
    when 'DS3'
      { 'appname': appname,
        'space': spacename,
        'image': image,
        'port': port
      }
    when 'BS1'
      { 'appname': appname,
        'space': spacename,
        'image': image,
        'port': port
      }
    when 'MARU'
    { 'appname': appname,
      'space': spacename,
      'image': image,
      'port': port
    }
    when 'LOCAL'
    { 'appname': appname,
      'space': spacename,
      'image': image,
        'port': port
    }
   end
  end
  let(:livecheckinfo) do
    case app.env+internalenv
    when 'DS1false'
      { 'url': 'https://'+appname+'-'+spacename+'.alamoapp.octanner.io'}
    when 'DS1true'
      { 'url': 'https://'+appname+'-'+spacename+'.alamoappi.octanner.io'}
    when 'DS2false'
      { 'url': 'https://'+appname+'-'+spacename+'.ds2app.octanner.io'}
    when 'DS2true'
      { 'url': 'https://'+appname+'-'+spacename+'.ds2appi.octanner.io'}
    when 'DS3false'
      { 'url': 'https://'+appname+'-'+spacename+'.ds3.octanner.io'}
    when 'DS3true'
      { 'url': 'https://'+appname+'-'+spacename+'.ds3i.octanner.io'}
    when 'BS1false'
          { 'url': 'https://'+appname+'-'+spacename+'.bs1.bigsquid.io'}
    when 'BS1true'
          { 'url': 'https://'+appname+'-'+spacename+'.bs1i.bigsquid.io'}
    when 'MARUfalse'
    { 'url': 'https://'+appname+'-'+spacename+'.maruapp.octanner.io'}
    when 'LOCAL'
    { 'url': 'https://'+appname+'-'+spacename+'.maruapp.octanner.io'}
    end
  end
  let(:appresponsebody) { app.regionapi.createapp(appinfo[:appname], appinfo[:appport]) } 
  let(:spaceappresponsebody) { app.regionapi.addapptospace(spaceappinfo[:appname], spaceappinfo[:space],spaceappinfo[:instances],spaceappinfo[:plan]) } 
  let(:configsetresponsebody) { app.regionapi.createconfigset(configsetinfo[:name], configsetinfo[:type]) } 
  let(:configvarresponsebody) { app.regionapi.addconfigvar(configvarinfo[:setname], configvarinfo[:varname],configvarinfo[:varvalue]) } 
  let(:deployresponsebody) { app.regionapi.deployapp(deployinfo[:appname], deployinfo[:space],deployinfo[:image],deployinfo[:port]) } 
  #let(:provisionpostgresbody) { app.regionapi.provisionpostgres(deployinfo[:appname], deployinfo[:space], "micro","test")}

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
    # expect(JSON.parse(provisionpostgresbody)).not_to be_empty    
  end
 



  before(:all) do
    $stdout.puts "running reset"
    case app.env
    when 'DS1'
      JSON.parse(app.regionapi.deleteconfigvar(appname+'-'+spacename, "PORT"))
      JSON.parse(app.regionapi.deleteconfigset(appname+'-'+spacename))
      JSON.parse(app.regionapi.deleteappfromspace(appname, spacename))
      JSON.parse(app.regionapi.deleteapp(appname))
      $stdout.puts "done with reset"
    when 'DS2'
      JSON.parse(app.regionapi.deleteconfigvar(appname+'-'+spacename, "PORT"))
      JSON.parse(app.regionapi.deleteconfigset(appname+'-'+spacename))
      JSON.parse(app.regionapi.deleteappfromspace(appname, spacename))
      JSON.parse(app.regionapi.deleteapp(appname))
      $stdout.puts "done with reset"
    when 'DS3'
      JSON.parse(app.regionapi.deleteconfigvar(appname+'-'+spacename, "PORT"))
      JSON.parse(app.regionapi.deleteconfigset(appname+'-'+spacename))
      JSON.parse(app.regionapi.deleteappfromspace(appname, spacename))
      JSON.parse(app.regionapi.deleteapp(appname))
      $stdout.puts "done with reset"
    when 'BS1'
      JSON.parse(app.regionapi.deleteconfigvar(appname+'-'+spacename, "PORT"))
      JSON.parse(app.regionapi.deleteconfigset(appname+'-'+spacename))
      JSON.parse(app.regionapi.deleteappfromspace(appname, spacename))
      JSON.parse(app.regionapi.deleteapp(appname))
      $stdout.puts "done with reset"
    when 'MARU'
      JSON.parse(app.regionapi.deleteconfigvar(appname+'-'+spacename, "PORT"))
      JSON.parse(app.regionapi.deleteconfigset(appname+'-'+spacename))
      JSON.parse(app.regionapi.deleteappfromspace(appname, spacename))
      JSON.parse(app.regionapi.deleteapp(appname))
      $stdout.puts "done with reset"
    when 'LOCAL'
      JSON.parse(app.regionapi.deleteconfigvar(appname+'-'+spacename, "PORT"))
      JSON.parse(app.regionapi.deleteconfigset(appname+'-'+spacename))
      JSON.parse(app.regionapi.deleteappfromspace(appname, spacename))
      JSON.parse(app.regionapi.deleteapp(appname))
      $stdout.puts "done with reset"
    end
  end


  after(:all) do
    $stdout.puts "running reset"
    case app.env
    when 'DS1'
      JSON.parse(app.regionapi.deleteconfigvar(appname+'-'+spacename, "PORT"))
      JSON.parse(app.regionapi.deleteconfigset(appname+'-'+spacename))
      JSON.parse(app.regionapi.deleteappfromspace(appname, spacename))
      JSON.parse(app.regionapi.deleteapp(appname))
      $stdout.puts "done with reset"
    when 'DS2'
      JSON.parse(app.regionapi.deleteconfigvar(appname+'-'+spacename, "PORT"))
      JSON.parse(app.regionapi.deleteconfigset(appname+'-'+spacename))
      JSON.parse(app.regionapi.deleteappfromspace(appname, spacename))
      JSON.parse(app.regionapi.deleteapp(appname))
      $stdout.puts "done with reset"
    when 'DS3'
      JSON.parse(app.regionapi.deleteconfigvar(appname+'-'+spacename, "PORT"))
      JSON.parse(app.regionapi.deleteconfigset(appname+'-'+spacename))
      JSON.parse(app.regionapi.deleteappfromspace(appname, spacename))
      JSON.parse(app.regionapi.deleteapp(appname))
      $stdout.puts "done with reset"
    when 'BS1'
      JSON.parse(app.regionapi.deleteconfigvar(appname+'-'+spacename, "PORT"))
      JSON.parse(app.regionapi.deleteconfigset(appname+'-'+spacename))
      JSON.parse(app.regionapi.deleteappfromspace(appname, spacename))
      JSON.parse(app.regionapi.deleteapp(appname))
      $stdout.puts "done with reset"
    when 'MARU'
      JSON.parse(app.regionapi.deleteconfigvar(appname+'-'+spacename, "PORT"))
      JSON.parse(app.regionapi.deleteconfigset(appname+'-'+spacename))
      JSON.parse(app.regionapi.deleteappfromspace(appname, spacename))
      JSON.parse(app.regionapi.deleteapp(appname))
      $stdout.puts "done with reset"
    when 'LOCAL'
      JSON.parse(app.regionapi.deleteconfigvar(appname+'-'+spacename, "PORT"))
      JSON.parse(app.regionapi.deleteconfigset(appname+'-'+spacename))
      JSON.parse(app.regionapi.deleteappfromspace(appname, spacename))
      JSON.parse(app.regionapi.deleteapp(appname))
      $stdout.puts "done with reset"
    end
   end




end
