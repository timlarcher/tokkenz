class PlayersController < ApplicationController

  include SessionsHelper

  before_filter :authenticate, :only => [ :show, :index, :edit, :update ]
  before_filter :admin_player, :only => [ :destroy ]
  before_filter :correct_player, :only => [ :edit, :update ]

  def new
    @player = Player.new
    @title = "sign up"
  end

  def create
    @player = Player.new(params[:player])
    if @player.save
      flash.now[:success] = "Welcome to tokkenz!"
      sign_in @player
      redirect_to @player
    else
      @title = 'sign up'
      @player.password = ""
      @player.password_confirmation = ""
      render 'new'
    end
  end

  def index
    @title = "index"
    @players = Player.paginate( :page => params[:page] )
  end

  def show
    @player = Player.find(params[:id])
    @stores = @player.stores
  end

  def edit
    @player = Player.find(params[:id])
    @title = "edit player"
  end

  def update
    @player = Player.find(params[:id])
    if @player.update_attributes(params[:player])
      flash[:success] = "profile was successfully updated."
      redirect_to @player
    else
      @title = "edit player"
      render 'edit'
    end
  end

  def destroy
    Player.find(params[:id]).destroy
    flash[:success] = "player destroyed."
    redirect_to players_path
  end

private

  def correct_player
    redirect_to root_path unless current_player.id == params[:id].to_i or admin_player?
  end

end
