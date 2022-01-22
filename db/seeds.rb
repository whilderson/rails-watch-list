# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'

# destroy existing seeds
puts 'destroy existing movie seeds'
Movie.destroy_all

# seed movies
url = 'http://tmdb.lewagon.com/movie/top_rated'
movies_serialised = URI.open(url).read
movies = JSON.parse(movies_serialised)
poster_base_url = 'https://image.tmdb.org/t/p/w500'
movies['results'].each do |movie|
  movie = Movie.create(title: movie['title'],
                       overview: movie['overview'],
                       poster_url: poster_base_url + movie['poster_path'],
                       rating: movie['vote_average'].to_f.round(1))
  p "created movie #{movie.id}"
  p movie.title
  p movie.overview
  p movie.poster_url
  p movie.rating
end

p 'ended generating movies'
