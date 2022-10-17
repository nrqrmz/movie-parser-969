require_relative 'scraper'
require 'yaml'

movies_urls = top_five_movies

movies_hash = movies_urls.map do |movie_url|
  movie_info(movie_url)
end

File.open('movies.yml', 'wb') do |file|
  file << YAML.dump(movies_hash)
end
