require 'rho/rhocontroller'

class PublicTimeline2Controller < Rho::RhoController

  #GET /PublicTimeline2
  def index
    @PublicTimeline2s = PublicTimeline2.find(:all)
    render
  end

  # GET /PublicTimeline2/1
  def show
    @PublicTimeline2 = PublicTimeline2.find(@params['id'])
    render :action => :show
  end

  # GET /PublicTimeline2/new
  def new
    @PublicTimeline2 = PublicTimeline2.new
    render :action => :new
  end

  # GET /PublicTimeline2/1/edit
  def edit
    @PublicTimeline2 = PublicTimeline2.find(@params['id'])
    render :action => :edit
  end

  # POST /PublicTimeline2/create
  def create
    @PublicTimeline2 = PublicTimeline2.new(@params['PublicTimeline2'])
    @PublicTimeline2.save
    redirect :action => :index
  end

  # POST /PublicTimeline2/1/update
  def update
    @PublicTimeline2 = PublicTimeline2.find(@params['id'])
    @PublicTimeline2.update_attributes(@params['PublicTimeline2'])
    redirect :action => :index
  end

  # POST /PublicTimeline2/1/delete
  def delete
    @PublicTimeline2 = PublicTimeline2.find(@params['id'])
    @PublicTimeline2.destroy
    redirect :action => :index
  end
end
