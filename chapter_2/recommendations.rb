#
# Chapter 2, making recommendations
#

require_relative 'pearson_coefficient'

class CriticComparison
  def self.pearson_similarity_ranking(critics, critic_name)
    ranking_list = critics.map do |current_critic_name, current_critic_movies|
      next if current_critic_name == critic_name
      [CriticComparison.new(critics[critic_name], current_critic_movies).
        pearson_coefficient, current_critic_name]
    end.compact
    ranking_list.sort.reverse
  end

  def initialize(critic1_movies, critic2_movies)
    @critic1_movies = critic1_movies
    @critic2_movies = critic2_movies
  end

  def similarity_score
    # also called 'Euclidian Distance Score'
    # in this example, the movies act as the axes, and the
    # critics are placed according to their scores of those
    # two movies. Distance between two critics is calculated.
    # Smaller distance = bigger similarity
    # bigger score = bigger similarity
    #
    return 0 if shared_movies.empty?

    1/(1+sum_of_squares)
  end

  def pearson_coefficient
    # Calculates a linear data fit line
    # and calculates the distance between the points
    # and the lines. the closer the points are to the
    # line the better the relation
    PearsonCoefficientCalculator.new(
      shared_movies,
      critic1_movies,
      critic2_movies
    ).calculate_coefficient
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
