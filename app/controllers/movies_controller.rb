require 'open-uri'

class MoviesController < ApplicationController
  def index
    search = params['search']
    if search.present?
      title = search['title']
      @movies = query_movies_via_tmdb(title)
    else
      @movies = Movie.all.order(:title)
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def result
    @movie = find_movie_by_tmdb_id(params[:format])
  end

  def add
    @movie = find_movie_by_tmdb_id(params[:format])
    if @movie.save
      redirect_to movies_path
    else
      redirect_to result_movies_path(params[:format])
    end
  end

  private

  def query_movies_via_tmdb(title)
    stringified_title = title.split(' ').join('+')
    url = "http://tmdb.lewagon.com/search/movie?&query=#{stringified_title}"
    serialised_movies = URI.open(url).read
    parsed_movies = JSON.parse(serialised_movies)['results']
    parsed_movies.map do |movie|
      Movie.new(title: movie['title'],
                overview: movie['overview'],
                poster_url: "https://image.tmdb.org/t/p/w500#{movie['poster_path']}",
                rating: movie['vote_average'].to_f.round(1),
                tmdb_id: movie['id'])
    end
  end

  def find_movie_by_tmdb_id(tmdb_id)
    url = "http://tmdb.lewagon.com/movie/#{tmdb_id}"
    serialised_movie = URI.open(url).read
    movie = JSON.parse(serialised_movie)
    Movie.new(title: movie['title'],
              overview: movie['overview'],
              poster_url: "https://image.tmdb.org/t/p/w500#{movie['poster_path']}",
              rating: movie['vote_average'].to_f.round(1),
              tmdb_id: movie['id'])
  end
end
