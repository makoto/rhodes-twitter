require 'rho/rhocontroller'

class PicTimeLineController < Rho::RhoController
@layout = :simplelayout

  #GET /PicTimeLine
  def index
    @pictimelines = PicTimeLine.find(:all)
    render
  end

  # GET /PicTimeLine/1
  def show
    @pictimeline = PicTimeLine.find(@params['id'])
    render :action => :show
  end

  # GET /PicTimeLine/new
  def new
    p "newR::::: PicTimeLine.find(:all).first "
    p PicTimeLine.find(:all).first 
    @pictimeline = PicTimeLine.find(:all).first || PicTimeLine.new
    render :action => :new
  end

  # GET /PicTimeLine/1/edit
  def edit 
    Camera::choose_picture(url_for :action => :camera_callback)
    redirect :action => :new
  end
  
  def camera_callback
    if @params['status'] == 'ok'
      @pictimelines = PicTimeLine.new({'image_uri'=>@params['image_uri']})
      @pictimelines.save
    end  
   render :action => :ok, :layout => false
  end

  # POST /PicTimeLine/create
  def create
    if @params['id']
      p "id exists"
      @pictimeline = PicTimeLine.find(@params['id'])
    else
      @pictimeline = PicTimeLine.new(@params['pictimeline'])
    end
    p "@pictimeline#{@pictimeline}"
    p "R@paRAms#{@params.inspect}"
    @pictimeline.update_attributes(@params['pictimeline'])
    @pictimeline.save
    SyncEngine::dosync
    redirect :action => :index
  end

  # POST /PicTimeLine/1/update
  # def update
  #   @pictimeline = PicTimeLine.find(@params['id'])
  #   @pictimeline.update_attributes(@params['PicTimeLine'])
  #   redirect :action => :index
  # end

  # POST /PicTimeLine/1/delete
  # def delete
  #   @pictimeline = PicTimeLine.find(@params['id'])
  #   @pictimeline.destroy
  #   redirect :action => :index
  # end
end
