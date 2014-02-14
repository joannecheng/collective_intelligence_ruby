# Chapter 2, making recommendations
class PearsonCorrelation

end

class SpearmanCorrelation

end

class CriticsDistance
  def initialize(critic1_movies, critic2_movies)
    @critic1_movies = critic1_movies
    @critic2_movies = critic2_movies
  end

  def similarity_score
    return 0 if shared_movies.empty?

    1/(1+sum_of_squares)
  end

  private
  attr_reader :critic1_movies, :critic2_movies

  def shared_movies
    @shared_movies ||= critic1_movies.keys & critic2_movies.keys
  end

  def sum_of_squares
    shared_movies.inject(0) do |sum, movie|
      sum + (critic1_movies[movie] - critic2_movies[movie])**2
    end
  end

end
