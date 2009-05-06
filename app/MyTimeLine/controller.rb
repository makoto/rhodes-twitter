require 'rho/rhocontroller'
require 'helpers/time_helper'
require 'helpers/application_helper'


class MyTimeLineController < Rho::RhoController
  include ApplicationHelper
  

  #GET /MyTimeLine
  def index
    @MyTimeLines = MyTimeLine.find(:all).reverse
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
    if @params['MyTimeLine']['text'].size >= 140
      # @MyTimeLine = MyTimeLine.new
      # @MyTimeLine = MyTimeLine.new(:text => @params['MyTimeLine']['text'], :error => "Too long")
      # redirect :action => :new
      redirect :action => :new, :query => {:error => "Too long: Max is 140 chars", :text => @params['MyTimeLine']['text']}
    else
      @MyTimeLine = MyTimeLine.new(@params['MyTimeLine'])
      @MyTimeLine.save
      redirect :action => :index
    end
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
