# Chapter 2, making recommendations
#
class CriticComparison
  def initialize(critic1_movies, critic2_movies)
    @critic1_movies = critic1_movies
    @critic2_movies = critic2_movies
  end

  def similarity_score
    # also called 'Euclidian Distance Score'
    return 0 if shared_movies.empty?

    1/(1+sum_of_squares)
  end

  def pearson_coefficient
    return 0 if shared_movies.empty?
    number_comparisons = shared_movies.length

    sum_critic1, sum_critic2 = sum_of_preferences_by_critic

    sum_squares_critic1, sum_squares_critic2 = sum_of_squares_by_critic

    numerator = sum_of_products - (sum_critic1*sum_critic2/number_comparisons)
    denominator = Math.sqrt(
      (sum_squares_critic1-sum_critic1**2/number_comparisons) *
      (sum_squares_critic2-sum_critic2**2/number_comparisons)
    )
    return 0 if denominator == 0

    numerator/denominator
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

  def sum_of_preferences_by_critic
    [critic1_movies, critic2_movies].map do |critic|
      shared_movies.inject(0) do |sum, movie|
        sum + critic[movie]
      end
    end
  end

  def sum_of_squares_by_critic
    [critic1_movies, critic2_movies].map do |critic|
      shared_movies.inject(0) do |sum, movie|
        sum + critic[movie]**2
      end
    end
  end

  def sum_of_products
    shared_movies.inject(0) do |sum, movie|
      sum + (critic1_movies[movie] * critic2_movies[movie])
    end
  end

end
