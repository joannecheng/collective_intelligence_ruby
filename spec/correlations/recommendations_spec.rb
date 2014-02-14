require_relative '../../correlations/recommendations'
require 'rspec'

describe CriticsDistance do

  describe '#distance' do
    it 'returns 0 if reviewers do not share any movies' do
      critic1 = {'movie1' => 2}
      critic2 = {'unmatching_movie' => 2}

      similarity_score = CriticsDistance.new(
        critic1,
        critic2
      ).similarity_score

      expect(similarity_score).to eq 0
    end

    it 'returns similarity score of two reviewers if they share movies' do
      similarity_score = CriticsDistance.new(
        critics['Lisa Rose'],
        critics['Gene Seymour']
      ).similarity_score

      expect(similarity_score).to eq 0.14814814814814814
    end
  end

  def critics
    {
      'Lisa Rose' => {
        'Lady in the Water' => 2.5,
        'Snakes on a Plane' => 3.5,
        'Just My Luck' => 3.0,
        'Superman Returns' => 3.5,
        'You, Me and Dupree' => 2.5,
        'The Night Listener' => 3.0
      },
      'Gene Seymour' => {
        'Lady in the Water' => 3.0,
        'Snakes on a Plane' => 3.5,
        'Just My Luck' => 1.5,
        'Superman Returns' => 5.0,
        'The Night Listener' => 3.0,
        'You, Me and Dupree' => 3.5
      },
      'Michael Phillips' => {
        'Lady in the Water' => 2.5,
        'Snakes on a Plane' => 3.0,
        'Superman Returns' => 3.5,
        'The Night Listener' => 4.0
      },
      'Claudia Puig' => {
        'Snakes on a Plane' => 3.5,
        'Just My Luck' => 3.0,
        'The Night Listener' => 4.5,
        'Superman Returns' => 4.0,
        'You, Me and Dupree' => 2.5
      },
      'Mick LaSalle' => {
        'Lady in the Water' => 3.0,
        'Snakes on a Plane' => 4.0,
        'Just My Luck' => 2.0,
        'Superman Returns' => 3.0,
        'The Night Listener' => 3.0,
        'You, Me and Dupree' => 2.0
      },
      'Jack Matthews' => {
        'Lady in the Water' => 3.0, 'Snakes on a Plane' => 4.0,
        'The Night Listener' => 3.0, 'Superman Returns' => 5.0, 'You, Me and Dupree' => 3.5
      },
      'Toby' => {
        'Snakes on a Plane' =>4.5,
        'You, Me and Dupree' =>1.0,
        'Superman Returns' =>4.0
      }
    }
  end
end
