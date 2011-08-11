class CharactersController < ApplicationController

  include SessionsHelper

  before_filter :authenticate, :except => [ :show, :index ]
  before_filter :admin_player, :except => [ :show, :index ]

  def new
    @character = Character.new
    @title = "add new character"
  end

  def create
    @character = Character.new(params[:character])
    if @character.save
      flash.now[:success] = "#{@character.name} added."
      redirect_to @character
    else
      @title = 'add new character'
      render 'new'
    end
  end

  def index
    @title = "list characters"
    @characters = Character.paginate( :page => params[:page] )
  end

  def show
    @character = Character.find(params[:id])
  end

  def edit
    @character = Character.find(params[:id])
    @title = "edit character"
  end

  def update
    @character = Character.find(params[:id])
    if @character.update_attributes(params[:Character])
      flash[:success] = "#{@character.name} was successfully updated."
      redirect_to @character
    else
      @title = "edit character"
      render 'edit'
    end
  end

  def destroy
    Character.find(params[:id]).destroy
    flash[:success] = "character deleted."
    redirect_to character_path
  end

end
