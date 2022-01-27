class MoviesController < ApplicationController
  def index
    @movies = Movie.all.order(:title)
  end

  def show
    @movie = Movie.find(params[:id])
  end
end
