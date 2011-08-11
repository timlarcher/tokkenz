class TradesController < ApplicationController

  include SessionsHelper

  before_filter :authenticate
  #before_filter :admin_player, :except => [ :create, :show, :index ]

  #def new
  #  @trade = trade.new
  #  @title = "add new trade"
  #end

  def create
    #
    # Fix this -- we need to create series.trades_per_pack trades
    # with random characters from the series.
    #
    @pack = Pack.find(params[:pack_id])
    @pack.series.trades_per_pack.times do
      @trade = Trade.create!( :player_id => current_player.id,
                              :character_id => 1 )
    end
    flash.now[:success] = "pack opened"
    @pack.destroy
    #@trades = trade.where( :player_id => current_player.id ).paginate( :page => params[:page] )
    @trades = current_player.trades.paginate( :page => params[:page] )
    render 'index'
  end

  def index
    @title = "list trades"
    @trades = current_player.trades.paginate( :page => params[:page] )
    #@trades = Trade.where( :player_id => current_player.id ).paginate( :page => params[:page] )
  end

  def show
    @trade = Trade.find(params[:id])
  end

  #def edit
  #  @trade = Trade.find(params[:id])
  #  @title = "edit trade"
  #end

  #def update
  #  @trade = Trade.find(params[:id])
  #  if @trade.update_attributes(params[:trade])
  #    flash[:success] = "#{@trade.name} was successfully updated."
  #    redirect_to @trade
  #  else
  #    @title = "edit trade"
  #    render 'edit'
  #  end
  #end

  def destroy
    Trade.find(params[:id]).destroy
    flash[:success] = "trade deleted."
    redirect_to trade_path
  end

end
