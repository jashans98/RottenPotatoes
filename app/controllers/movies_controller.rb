class MoviesController < ApplicationController
  def index
    @movies = Movie.all
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
    valid_params = params.require(:movie).permit(:title, :rating, :release_date)
    @movie = Movie.create(valid_params)
    if @movie != nil
      flash[:notice] = "#{@movie.title} was successfully created"
    else
      flash[:warning] = "Error creating #{@movie.title}"
    end
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    valid_params = params.require(:movie).permit(:title, :rating, :release_date)
    @movie = Movie.find(params[:id])
    @movie.update_attributes(valid_params)
    flash[:notice] = "#{@movie.title} was successfully updated"
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "#{@movie.title} was successfully deleted"
    redirect_to movies_path
  end
end
