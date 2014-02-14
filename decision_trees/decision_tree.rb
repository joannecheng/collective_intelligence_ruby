class DecisionTree

  def self.classify(observation, tree)
    if tree.results
      return tree.results
    end

  end

  def self.build_tree(rows, score_type = 'entropy')
    return EmptyDecisionNode.new if rows.empty?

    d = DecisionTree.new(rows)
    best_gain = 0
    best_criteria = nil
    best_set = nil

    rows[0].length.times do |col|
      rows.each do |row|
        column_value = row[col]
        set1, set2 = d.divide_set(col, column_value)
        gain = calculate_gain(set1, set2, d)

        if gain > best_gain && set1.length > 0 && set2.length > 0
          best_gain = gain
          best_criteria = [col, column_value]
          best_set = [set1, set2]
        end
      end

      if best_gain > 0
        true_branch = build_tree(best_set[0])
        false_branch = build_tree(best_set[1])

        DecisionNode.new(column_index: best_criteria[0],
                         value: best_criteria[1], tb: true_branch,
                         fb: false_branch)
      else
        DecisionNode.new(results: d.unique_counts(rows))
      end
    end
  end

  def self.calculate_gain(set1, set2, d)
    rows_length = (set1 + set2).length
    p = set1.length.to_f/rows_length
    d.entropy - p*d.entropy(set1) - (1-p)*d.entropy(set2)
  end

  def initialize(rows)
    @rows = rows
  end

  def divide_set(column_index, value)
    if value.kind_of? Numeric
      set1 = @rows.select { |row| row[column_index] >= value }
    else
      set1 = @rows.select { |row| row[column_index] == value }
    end

    [set1, @rows - set1]
  end

  def unique_counts(rows = nil)
    rows = @rows if rows.nil?
    results = {}
    rows.each do |row|
      result = row.last.downcase.to_sym
      results[result] ||= 0 and results[result] += 1
    end
    results
  end

  def gini_impurity(rows = nil)
    rows = @rows if rows.nil?
    counts = unique_counts(rows)
    impurity = 0

    counts.each do |word1, count1|
      p1 = 1.0*count1/rows.length
      counts.each do |word2, count2|
        next if word1 == word2

        p2 = 1.0*count2/rows.length
        impurity += p1*p2
      end
    end
    impurity
  end

  def entropy(rows = nil)
    rows = @rows if rows.nil?

    unique_counts(rows).inject(0) do |entropy, item|
      p = item[1]*1.0/rows.length
      entropy = entropy - p*Math.log(p, 2)
    end
  end

end

class DecisionNode
  attr_reader :column_index, :value, :results, :tb, :fb

  def initialize(options = {})
    @column_index = options[:column_index]
    @value = options[:value]
    @results = options[:results]
    @tb = options[:tb]
    @fb = options[:fb]
  end
end

class EmptyDecisionNode

end
