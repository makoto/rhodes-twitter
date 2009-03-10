require 'rho/rhocontroller'

class MyTimeLineController < Rho::RhoController

  #GET /MyTimeLine
  def index
    require 'rho'
    p "Rho::RhoConfig::sources"
    p Rho::RhoConfig::sources.inspect
    
    p "Rho::RhoConfig::sources[self.name.to_s]"
    p Rho::RhoConfig::sources["MyTimeLine"]
    
    @MyTimeLines = MyTimeLine.find(:all)
    p "@MyTimeLines.class #{@MyTimeLines.class}"
    p @MyTimeLines.inspect
    # p "@MyTimeLines.first.keys #{@MyTimeLines.first.keys.join(',')}"
    # first = @MyTimeLines.first
    # first.keys.each do |k|
    #   p "first.send(k.to_sym)"
    #   p first.send(k.to_sym)
    # end
    # @MyTimeLines.each do |t|
    #   p t.id
    # end
    render
  end

  # GET /MyTimeLine/1
  def show
    @MyTimeLine = MyTimeLine.find(@params['id'])
    render :action => :show
  end

  # GET /MyTimeLine/new
  def new
    @MyTimeLine = MyTimeLine.new
    render :action => :new
  end

  # GET /MyTimeLine/1/edit
  def edit
    @MyTimeLine = MyTimeLine.find(@params['id'])
    render :action => :edit
  end

  # POST /MyTimeLine/create
  def create
    @MyTimeLine = MyTimeLine.new(@params['MyTimeLine'])
    @MyTimeLine.save
    redirect :action => :index
  end

  # POST /MyTimeLine/1/update
  def update
    @MyTimeLine = MyTimeLine.find(@params['id'])
    @MyTimeLine.update_attributes(@params['MyTimeLine'])
    redirect :action => :index
  end

  # POST /MyTimeLine/1/delete
  def delete
    @MyTimeLine = MyTimeLine.find(@params['id'])
    @MyTimeLine.destroy
    redirect :action => :index
  end
end
