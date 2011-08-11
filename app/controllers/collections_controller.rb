class CollectionsController < ApplicationController

  include SessionsHelper

  before_filter :authenticate, :except => [ :show, :index ]
  before_filter :admin_player, :except => [ :show, :index ]

  def new
    @collection = Collection.new
    @title = "add new collection"
  end

  def create
    @collection = Collection.new( params[:collection] )
    if @collection.save
      flash.now[:success] = "collection added."
      redirect_to @collection
    else
      @title = 'add new collection'
      render 'new'
    end
  end

  def index
    @title = "list collections"
    @collection = Collection.paginate( :page => params[:page] )
  end

  def show
    @collection = Collection.find(params[:id])
  end

  def edit
    @collection = Collection.find(params[:id])
    @title = "edit collection"
  end

  def update
    @collection = Collection.find(params[:id])
    if @collection.update_attributes(params[:collection])
      flash[:success] = "#{@collection.name} was successfully updated."
      redirect_to @collection
    else
      @title = "edit collection"
      render 'edit'
    end
  end

  def destroy
    Collection.find(params[:id]).destroy
    flash[:success] = "collection deleted."
    redirect_to collection_path
  end

end
