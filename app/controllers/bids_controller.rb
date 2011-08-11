class BidsController < ApplicationController

  include SessionsHelper

  before_filter :authenticate
  #before_filter :admin_player, :except => [ :create, :show, :index ]

  def new
    @bid = Bid.new
    @title = "bid on a bid"
    @tokens = current_player.tokens
    session[:trade_id] = params[:trade_id]
  end

  def create
    @bid = Bid.create!( params[:bid] ) do |b|
      b.player_id = current_player.id
      b.trade_id = session[:trade_id]
    end
    BidToken.create!( :token_id => params[:token_id],
                      :bid_id => @bid.id )
    flash.now[:success] = "bid created"
    @bids = current_player.bids.where(:closed => false).paginate( :page => params[:page] )
    @title = "my bids"
    render 'index'
  end

  def index
    @title = "my bids"
    @bids = current_player.bids.where(:closed => false).paginate( :page => params[:page] )
    @trades = @bids.map { |b| b.trade_id }
  end

  def bid_bids
    @title = "bids for bid"
    @bids = Bids.find(:all, :conditions => ["bid_id = ?",params[bid_id]]).where(:closed => false).paginate( :page => params[:page] )
  end

  def show
    @bid = Bid.find(params[:id])
  end

  def accept
    #@bid = Bid.find(params[:bid_id])
    @bid = Bid.find(params[:id])
    @bid.tokens.each do |t|
      t.player_id = @bid.player_id
      t.save
    end
    @bid.tokens.each do |t|
      t.player_id = @bid.player_id
      t.save
    end
    redirect_to 'tokens/index'
  end

  def cancel
    @bid = bid.find(params[:id])
    @bid.closed = true
    @bid.save
    @bids = current_player.bids.where(:closed => false).paginate( :page => params[:page] )
    flash[:success] = "bid cancelled"
    render 'index'
  end

  #def edit
  #  @bid = Bid.find(params[:id])
  #  @title = "edit bid"
  #end

  #def update
  #  @bid = Bid.find(params[:id])
  #  if @bid.update_attributes(params[:bid])
  #    flash[:success] = "#{@bid.name} was successfully updated."
  #    redirect_to @bid
  #  else
  #    @title = "edit bid"
  #    render 'edit'
  #  end
  #end

  def destroy
    Bid.find(params[:id]).destroy
    flash[:success] = "bid deleted"
    redirect_to bids_path
  end

end
