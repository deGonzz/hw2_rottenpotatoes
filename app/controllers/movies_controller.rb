# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController

  def index
    session[:order] = params[:order] || session[:order] 
    #session[] is a hash that persists across requests. Here, either a movie's primary key (their order, if nothing needs to be stored in
    # between actions) or a previous saved session primary keys, is stored into the session hash
    @all_ratings = Movie.pluck(:rating).uniq
    @selected_column = session[:order]
    @selected_ratings = params[:ratings]
    if @selected_ratings == nil
      @movies = Movie.order(session[:order])
    end
    if @selected_ratings != nil
      @movies = Movie.where(:rating => @selected_ratings)
    end
    # debugger
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # Look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
