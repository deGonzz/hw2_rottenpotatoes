# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController

  def index
    #  if session[:order] == params[:order]
    #    session[:order] = 'rating'
    # end
    # # else
      session[:order] = params[:order] || session[:order]
    # end
    #debugger
    @all_ratings = Movie.pluck(:rating).uniq
    # @movies = Movie.order(session[:order])
    @selected_column = session[:order]
    @selected_ratings = params[:ratings]
    if @selected_ratings == nil
      @movies = Movie.order(session[:order])
    end
    if @selected_ratings != nil
      @movies = Movie.where(:rating => @selected_ratings)
    end
    # @ratings = Movie.order(session[:order])
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
