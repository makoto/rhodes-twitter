require 'rho/rhocontroller'

class GeoTimeLineController < Rho::RhoController

  #GET /GeoTimeLine
  def index
    latitude =  GeoLocation.latitude.to_s
    longitude = GeoLocation.longitude.to_s
    range = "25km"

    question = "#{latitude},#{longitude}"

    # Not sure how this works yet.
    # range = "25km"
    # url = "/search.json?geocode=#{latitude}%2C#{longitude}%2C#{range}"
    # GeoTimeLine.set_notification("url")

    SyncEngine::set_notification(13,"/GeoTimeLine", "question=" + question)

    GeoTimeLine.ask(question)

    require 'rhom'
    p "Rhom::RhomDbAdapter::select_from_table 1" 
    p Rhom::RhomDbAdapter::select_from_table('object_values','*', :source_id => 13)
    p "EOF |||||||||||||||"
    
    sleep 10
    
    p "Rhom::RhomDbAdapter::select_from_table 2" 
    p Rhom::RhomDbAdapter::select_from_table('object_values','*', :source_id => 13)
    p "EOF |||||||||||||||"
    @GeoTimeLines = GeoTimeLine.find(:all)
    
    render :action => :index
  end

  # GET /GeoTimeLine/1
  def show
    @GeoTimeLine = GeoTimeLine.find(@params['id'])
    render :action => :show
  end

  # GET /GeoTimeLine/new
  def new
    @GeoTimeLine = GeoTimeLine.new
    render :action => :new
  end

  # GET /GeoTimeLine/1/edit
  def edit
    @GeoTimeLine = GeoTimeLine.find(@params['id'])
    render :action => :edit
  end

  # POST /GeoTimeLine/create
  def create
    @GeoTimeLine = GeoTimeLine.new(@params['GeoTimeLine'])
    @GeoTimeLine.save
    redirect :action => :index
  end

  # POST /GeoTimeLine/1/update
  def update
    @GeoTimeLine = GeoTimeLine.find(@params['id'])
    @GeoTimeLine.update_attributes(@params['GeoTimeLine'])
    redirect :action => :index
  end

  # POST /GeoTimeLine/1/delete
  def delete
    @GeoTimeLine = GeoTimeLine.find(@params['id'])
    @GeoTimeLine.destroy
    redirect :action => :index
  end
end
