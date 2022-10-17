require 'open-uri'
require 'nokogiri'
require 'pry-byebug'

def top_five_movies
  url = "https://www.imdb.com/chart/top"
  html_file = URI.open(url).read
  doc = Nokogiri::HTML(html_file)
  movies = doc.search('.titleColumn a').take(5)

  movies.map { |movie| "https://www.imdb.com#{movie.attr(:href)}" }
end

def movie_info(url)
  html_file = URI.open(url, "Accept-Language" => "en-US").read
  doc = Nokogiri::HTML(html_file)

  title = doc.search('h1').text
  year = doc.search('.ipc-inline-list__item span').first.text.to_i
  plot = doc.search('.sc-16ede01-2').text
  director = doc.at('.ipc-metadata-list-item__list-content-item.ipc-metadata-list-item__list-content-item--link').text
  cast = doc.search('.ipc-metadata-list__item:contains("Stars") .ipc-metadata-list-item__list-content-item').map(&:text).uniq

  {
    title: title,
    year: year,
    plot: plot,
    director: director,
    cast: cast
  }
end

movie_info("https://www.imdb.com/title/tt0468569/")
