class PearsonCoefficientCalculator
  def initialize(shared_movies, critic1_movies, critic2_movies)
    @shared_movies = shared_movies
    @critic1_movies = critic1_movies
    @critic2_movies = critic2_movies
  end

  def calculate_coefficient
    return 0 if shared_movies.empty?
    return 0 if denominator == 0
    numerator/denominator
  end

  private

  def numerator
    sum_critic1, sum_critic2 = sum_of_preferences_by_critic
    sum_of_ratings_products - (sum_critic1*sum_critic2/shared_movies.length)
  end

  def denominator
    sum_critic1, sum_critic2 = sum_of_preferences_by_critic
    sum_squares_critic1, sum_squares_critic2 = sum_of_squares_by_critic
    @denominator ||= Math.sqrt(
      (sum_squares_critic1-sum_critic1**2/shared_movies.length) *
      (sum_squares_critic2-sum_critic2**2/shared_movies.length)
    )
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

  def sum_of_ratings_products
    shared_movies.inject(0) do |sum, movie|
      sum + (critic1_movies[movie] * critic2_movies[movie])
    end
  end

  attr_reader :shared_movies, :critic1_movies, :critic2_movies
end

