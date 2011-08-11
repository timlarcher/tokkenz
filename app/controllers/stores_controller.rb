class StoresController < ApplicationController

  include SessionsHelper

  def new
    @store = Store.new
    @title = "sign up"
  end

  def create
    @store = Store.new(params[:store])
    @store.player_id = current_player.id
    if @store.save
      flash.now[:success] = "Welcome to your new store!"
      redirect_to @store
    else
      @title = 'add new store'
      render 'new'
    end
  end

  def index
    @title = "index"
    @stores = Store.paginate( :page => params[:page] )
  end

  def show
    @store = Store.find(params[:id])
  end

  def edit
    @store = Store.find(params[:id])
    @title = "edit store"
  end

  def update
    @store = Store.find(params[:id])
    if @store.update_attributes(params[:store])
      flash[:success] = "profile was successfully updated."
      redirect_to @store
    else
      @title = "edit store"
      render 'edit'
    end
  end

  def destroy
    Store.find(params[:id]).destroy
    flash[:success] = "store destroyed."
    redirect_to stores_path
  end

end
