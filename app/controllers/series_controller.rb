class SeriesController < ApplicationController

  include SessionsHelper

  before_filter :authenticate, :except => [ :show, :index ]
  before_filter :admin_player, :except => [ :show, :index ]

  def new
    @series = Series.new
    @title = "add new series"
  end

  def create
    @series = Series.new(params[:series])
    if @series.save
      flash.now[:success] = "#{@series.name} added."
      redirect_to @series
    else
      @title = 'add new series'
      render 'new'
    end
  end

  def index
    @title = "list series"
    @series = Series.where( "packs_minted > packs_issued" ).paginate( :page => params[:page] )
  end

  def show
    @series = Series.find(params[:id])
  end

  def edit
    @series = Series.find(params[:id])
    @title = "edit series"
  end

  def update
    @series = Series.find(params[:id])
    if @series.update_attributes(params[:series])
      flash[:success] = "#{@series.name} was successfully updated."
      redirect_to @series
    else
      @title = "edit series"
      render 'edit'
    end
  end

  def destroy
    Series.find(params[:id]).destroy
    flash[:success] = "series deleted."
    redirect_to series_path
  end

end
