class PacksController < ApplicationController

  include SessionsHelper

  before_filter :authenticate
  #before_filter :admin_player, :except => [ :create, :show, :index ]

  #def new
  #  @pack = Pack.new
  #  @title = "add new pack"
  #end

  def create
    @series = Series.find(params[:series_id])
    @pack = Pack.new( :player_id => current_player.id,
                      :series_id => params[:series_id],
                      :quantity => 1 )
    if @pack.save
      @series.packs_issued += 1
      @series.save
      flash.now[:success] = "pack added."
      render 'show'
    else
      render 'index'
    end
  end

  def index
    @title = "list packs"
    @packs = current_player.packs.paginate( :page => params[:page] )
    #@packs = Pack.where( :id => current_player.id ).paginate( :page => params[:page] )
  end

  def show
    @pack = Pack.find(params[:id])
    @series = Series.find(@pack.series_id)
  end

  #def edit
  #  @pack = Pack.find(params[:id])
  #  @title = "edit pack"
  #end

  #def update
  #  @pack = Pack.find(params[:id])
  #  if @pack.update_attributes(params[:pack])
  #    flash[:success] = "#{@pack.name} was successfully updated."
  #    redirect_to @pack
  #  else
  #    @title = "edit pack"
  #    render 'edit'
  #  end
  #end

  def destroy
    Pack.find(params[:id]).destroy
    flash[:success] = "pack deleted."
    redirect_to pack_path
  end

end
