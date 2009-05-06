require 'rho/rhocontroller'
require 'helpers/time_helper'
require 'helpers/application_helper'


class PicTimeLineController < Rho::RhoController
  include ApplicationHelper
  
# @layout = :simplelayout

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
      WebView::navigate( url_for( :action => :new, :query => {:image_local_path =>  @params['image_uri'].gsub(/%2F/,'/')} ) )
    end  
   render :action => :new
  end

  # POST /PicTimeLine/create
  def create
    if @params['pictimeline']['text'].size >= 140
      redirect :action => :new, :query => {:error => "Too long: Max is 140 chars", :text => @params['pictimeline']['text']}
    else
      @pictimeline = PicTimeLine.new(
        {
        'image_uri' => @params['pictimeline']['image_uri'].gsub(/%2F/,'/'), 
        'text'      => @params['pictimeline']['text']
        }
      )
      @pictimeline.save
      SyncEngine::dosync
      redirect :action => :index
    end
  end

  # POST /PicTimeLine/1/update
  def update
    @pictimeline = PicTimeLine.find(@params['id'])
    @pictimeline.update_attributes(@params['PicTimeLine'])
    redirect :action => :index
  end

  # POST /PicTimeLine/1/delete
  def delete
    @pictimeline = PicTimeLine.find(@params['id'])
    @pictimeline.destroy
    redirect :action => :index
  end
end
