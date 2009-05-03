require 'rho/rhocontroller'
require 'helpers/time_helper'

class PublicTimeLineController < Rho::RhoController
  
  #GET /PublicTimeLine
  def index
    @PublicTimeLines = PublicTimeLine.find(:all).reverse
    render :action => :index
  end

  # GET /PublicTimeLine/1
  def show
    @PublicTimeLines = PublicTimeLine.find(@params['object'])
    render :action => :show
  end

  # GET /PublicTimeLine/new
  def new
    @PublicTimeLine = PublicTimeLine.new
    render :action => :new
  end

  # GET /PublicTimeLine/1/edit
  def edit
    @PublicTimeLine = PublicTimeLine.find(@params['id'])
    render :action => :edit
  end

  # POST /PublicTimeLine/create
  def create
    @PublicTimeLine = PublicTimeLine.new(@params['PublicTimeLine'])
    @PublicTimeLine.save
    redirect :action => :index
  end

  # POST /PublicTimeLine/1/update
  def update
    @PublicTimeLine = PublicTimeLine.find(@params['id'])
    @PublicTimeLine.update_attributes(@params['PublicTimeLine'])
    redirect :action => :index
  end

  # POST /PublicTimeLine/1/delete
  def delete
    @PublicTimeLine = PublicTimeLine.find(@params['id'])
    @PublicTimeLine.destroy
    redirect :action => :index
  end
end
