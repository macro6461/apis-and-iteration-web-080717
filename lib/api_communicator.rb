require 'rest-client'
require 'json'
require 'pry'

def get_target_character(character)

  character_hash = JSON.parse(RestClient.get('http://www.swapi.co/api/people/'))

  target_character = character_hash["results"].select do |item|
    item["name"].downcase == character
  end[0]

end

def collect_film_hashes(character)

  target_character = get_target_character(character)

  target_character["films"].collect do |movie_url|
    movie = JSON.parse(RestClient.get(movie_url))
  end

end

def get_character_movies_from_api(character)
  #make the web request
  collect_film_hashes(character)

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film

  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each_with_index do |movie, index|
    puts "#{index + 1}. #{movie["title"]}"
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
