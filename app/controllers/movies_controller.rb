class MoviesController < ApplicationController
  def index
    if params[:sort_by]
      @movies = Movie.order(params[:sort_by])
    else
      @movies = Movie.all
    end
    # handed over to index.html.haml
  end

  def show
    @movie = Movie.find(params[:id])
    # handed over to show.html.haml
  end

  def new
    @movie = Movie.new
    # handed over to new.html.haml
  end

  def create
    @movie = Movie.create(movie_params)
    if @movie != nil
      flash[:notice] = "#{@movie.title} was successfully created"
    else
      flash[:warning] = "Error creating #{@movie.title}"
    end
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find(params[:id])
    # handed over to edit.html.haml
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update_attributes(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated"
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "#{@movie.title} was successfully deleted"
    redirect_to movies_path
  end

  def movie_params
    # helper method to get movie allowed params easily
    params.require(:movie).permit(:title, :rating, :release_date, :description)
  end
end
