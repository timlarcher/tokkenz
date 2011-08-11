class MainController < ApplicationController

  def welcome
    @title = "Home"
  end

  def home
    @title = "Home"
  end

  def contact
    @title = "Contact"
  end

  def about
    @title = "About"
  end

  def help
    @title = "Help"
  end

  def jobs
    @title = "Help"
  end

  def search
    @all_series = Series.all
    @series = []
    upcase_search_string = params[:search_string].upcase
    @all_series.each do |s|
      if s.name.upcase.include?(upcase_search_string)
        @series << s
      end
    end
    #@series.paginate( :page => params[:page] )
  end

  def whats_new
    @title = "what\'s new?"
    @series = Series.paginate( :page => params[:page] )
  end

end
