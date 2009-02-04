require 'rho/rhocontroller'
require File.join(__rhoGetCurrentDir(), 'apps','Twitter','lib/time_helper')

class TimeLineController < Rho::RhoController
  
  #GET /TimeLine
  def index
    @TimeLines = TimeLine.find(:all)
    # @TimeLines = @TimeLines.map{|tl| tl.created_at = timeago(parse_time(tl.created_at)); tl}
    render :index
  end

  # GET /TimeLine/1
  def show
    @TimeLines = TimeLine.find(@params['object'])
  end

  # GET /TimeLine/new
  def new
    @TimeLine = TimeLine.new
    render :new
  end

  # GET /TimeLine/1/edit
  def edit
    @TimeLine = TimeLine.find(@params['id'])
    render :edit
  end

  # POST /TimeLine/create
  def create
    @TimeLine = TimeLine.new(@params['TimeLine'])
    @TimeLine.save
    redirect :index
  end

  # POST /TimeLine/1/update
  def update
    @TimeLine = TimeLine.find(@params['id'])
    @TimeLine.update_attributes(@params['TimeLine'])
    redirect :index
  end

  # POST /TimeLine/1/delete
  def delete
    @TimeLine = TimeLine.find(@params['id'])
    @TimeLine.destroy
    redirect :index
  end
end
