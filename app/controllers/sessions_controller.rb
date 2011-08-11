class SessionsController < ApplicationController

  include SessionsHelper

  def new
    @title = "Sign in"
  end

  def create
    player = Player.authenticate( params[:session][:email], params[:session][:password] )
    if player
      flash.now[:success] = "Welcome back, #{player.handle}."
      sign_in player
      redirect_back_or(player)
    else
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

end
