class StarsController < ApplicationController

  include SessionsHelper

  before_filter :authenticate, :except => [ :show, :index ]
  before_filter :admin_player, :except => [ :show, :index ]

  def new
    @star = Star.new
    @title = "add new star"
  end

  def create
    @star = Star.new(params[:star])
    if @star.save
      flash.now[:success] = "#{@star.name} added."
      redirect_to @star
    else
      @title = 'add new star'
      render 'new'
    end
  end

  def index
    @title = "list stars"
    @stars = Star.paginate( :page => params[:page] )
  end

  def show
    @star = Star.find(params[:id])
  end

  def edit
    @star = Star.find(params[:id])
    @title = "edit star"
  end

  def update
    @star = Star.find(params[:id])
    if @star.update_attributes(params[:star])
      flash[:success] = "#{@star.name} was successfully updated."
      redirect_to @star
    else
      @title = "edit star"
      render 'edit'
    end
  end

  def destroy
    Star.find(params[:id]).destroy
    flash[:success] = "star deleted."
    redirect_to stars_path
  end

end
