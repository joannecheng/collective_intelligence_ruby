class Classifier
  def initialize(get_features)
    @feature_category_counts = {}
    @category_counts = {}

    @get_features = get_features
  end

  def increase_feature_category_count(feature, category)
    @feature_category_counts[feature] ||= {}
    @feature_category_counts[feature][category] ||= 0

    @feature_category_counts[feature][category] += 1
  end

  def increase_category_count(category)
    @category_counts[category] ||= 0
    @category_counts[category] += 1
  end

  # number of times a feature has appeared in a category
  def feature_count(feature, category)
    @feature_category_counts[feature][category] || 0
  end

  def category_count(category)
    @category_counts[category] || 0
  end

  def train(item, category)
    # determine counts for each category
  end

end
