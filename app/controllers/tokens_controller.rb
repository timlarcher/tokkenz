class TokensController < ApplicationController

  include SessionsHelper

  before_filter :authenticate
  #before_filter :admin_player, :except => [ :create, :show, :index ]

  #def new
  #  @token = token.new
  #  @title = "add new token"
  #end

  def create
    #
    # Fix this -- we need to create series.tokens_per_pack tokens
    # with random characters from the series.
    #
    @pack = Pack.find(params[:pack_id])
    @pack.series.tokens_per_pack.times do
      @token = Token.create!( :player_id => current_player.id,
                              :character_id => 1 )
    end
    flash.now[:success] = "pack opened"
    @pack.destroy
    #@tokens = Token.where( :player_id => current_player.id ).paginate( :page => params[:page] )
    @tokens = current_player.tokens.paginate( :page => params[:page] )
    render 'index'
  end

  def index
    @title = "list tokens"
    @tokens = current_player.tokens.paginate( :page => params[:page] )
    #@tokens = Token.where( :player_id => current_player.id ).paginate( :page => params[:page] )
  end

  def show
    @token = Token.find(params[:id])
  end

  #def edit
  #  @token = token.find(params[:id])
  #  @title = "edit token"
  #end

  #def update
  #  @token = token.find(params[:id])
  #  if @token.update_attributes(params[:token])
  #    flash[:success] = "#{@token.name} was successfully updated."
  #    redirect_to @token
  #  else
  #    @title = "edit token"
  #    render 'edit'
  #  end
  #end

  def destroy
    Token.find(params[:id]).destroy
    flash[:success] = "token deleted."
    redirect_to token_path
  end

end
