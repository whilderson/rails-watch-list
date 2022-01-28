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

  def search
    @movies = query_movies_via_tmdb('test')
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
                rating: movie['vote_average'].to_f.round(1))
    end
  end
end
