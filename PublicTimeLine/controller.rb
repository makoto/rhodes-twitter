require 'rho/rhocontroller'

class PublicTimeLineController < Rho::RhoController
  
  #GET /PublicTimeLine
  def index
    @PublicTimeLines = PublicTimeLine.find(:all)
    render :index
  end

  # GET /PublicTimeLine/1
  def show
    @PublicTimeLines = PublicTimeLine.find(@params['object'])
  end

  # GET /PublicTimeLine/new
  def new
    @PublicTimeLine = PublicTimeLine.new
    render :new
  end

  # GET /PublicTimeLine/1/edit
  def edit
    @PublicTimeLine = PublicTimeLine.find(@params['id'])
    render :edit
  end

  # POST /PublicTimeLine/create
  def create
    @PublicTimeLine = PublicTimeLine.new(@params['PublicTimeLine'])
    @PublicTimeLine.save
    redirect :index
  end

  # POST /PublicTimeLine/1/update
  def update
    @PublicTimeLine = PublicTimeLine.find(@params['id'])
    @PublicTimeLine.update_attributes(@params['PublicTimeLine'])
    redirect :index
  end

  # POST /PublicTimeLine/1/delete
  def delete
    @PublicTimeLine = PublicTimeLine.find(@params['id'])
    @PublicTimeLine.destroy
    redirect :index
  end
end
