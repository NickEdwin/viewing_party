class MovieService
  def top_rated
    top_rated1 = conn.get("/3/movie/top_rated?api_key=#{ENV['MOVIE_DATA_BASE_API_KEY']}&language=en-US&page=1")
    top_rated2 = conn.get("/3/movie/top_rated?api_key=#{ENV['MOVIE_DATA_BASE_API_KEY']}&language=en-US&page=2")

    page1 = JSON.parse(top_rated1.body, symbolize_names: true)
    page2 = JSON.parse(top_rated2.body, symbolize_names: true)

    top40 = (page1[:results] << page2[:results]).flatten!
    top40
  end

  def search(keywords)
    search1 = conn.get("/3/search/movie?api_key=#{ENV['MOVIE_DATA_BASE_API_KEY']}&query=#{keywords}&page=1")
    search2 = conn.get("/3/search/movie?api_key=#{ENV['MOVIE_DATA_BASE_API_KEY']}&query=#{keywords}&page=2")

    page1 = JSON.parse(search1.body, symbolize_names: true)
    page2 = JSON.parse(search2.body, symbolize_names: true)

    top40 = (page1[:results] << page2[:results]).flatten!
    top40
  end

  def details(id)
    movie = conn.get("/3/movie/#{id}?api_key=#{ENV['MOVIE_DATA_BASE_API_KEY']}")
    JSON.parse(movie.body, symbolize_names: true)
  end

  def cast(id)
    movie_cast = conn.get("/3/movie/#{id}/credits?api_key=#{ENV['MOVIE_DATA_BASE_API_KEY']}")
    JSON.parse(movie_cast.body, symbolize_names: true)
  end

  def reviews(id)
    reviews = conn.get("/3/movie/#{id}/reviews?api_key=#{ENV['MOVIE_DATA_BASE_API_KEY']}&language=en-US")
    JSON.parse(reviews.body, symbolize_names: true)
  end

  def videos(id)
    videos = conn.get("/3/movie/#{id}/videos?api_key=#{ENV['MOVIE_DATA_BASE_API_KEY']}&language=en-US")
    JSON.parse(videos.body, symbolize_names: true)
  end

  def recommended(id)
    recommended = conn.get("/3/movie/#{id}/recommendations?api_key=#{ENV['MOVIE_DATA_BASE_API_KEY']}&language=en-US")
    JSON.parse(recommended.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(url: 'https://api.themoviedb.org')
  end
end
