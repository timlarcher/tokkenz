class TradesController < ApplicationController

  include SessionsHelper

  before_filter :authenticate, :except => [ :search, :show, :index ]

  def new
    @trade = Trade.new
    @title = "propose trade"
    session[:token_id] = params[:token_id]
  end

  def create
    @trade = Trade.create!( params[:trade] ) do |t|
      t.player_id = current_player.id
    end
    TradeToken.create!( :token_id => session[:token_id],
                        :trade_id => @trade.id )
    flash.now[:success] = "trade created"
    session[:token_id] = nil
    # debug session[:trade] = params[:trade]
    @trades = current_player.trades.where(:closed => false).paginate( :page => params[:page] )
    @title = "my trades"
    render 'index'
  end

  def index
    @title = "my trades"
    @trades = current_player.trades.where(:closed => false).paginate( :page => params[:page] )
  end

  def show
    @trade = Trade.find(params[:id])
    @bids = @trade.bids.where(:closed => false).paginate( :page => params[:page] )
  end

  def search
    @title = "list trades"
    @trades = Trade.find(:all,:conditions => ["player_id != ?", current_player.id]).paginate( :page => params[:page] )
    render 'index'
  end

  def cancel
    @trade = Trade.find(params[:id])
    @trade.closed = true
    @trade.save
    @trade.bids.each do |b|
      b.closed = true
      b.save
    end
    @trades = current_player.trades.where(:closed => false).paginate( :page => params[:page] )
    flash[:success] = "trade cancelled"
    render 'index'
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
    redirect_to trades_path
  end

end
