class DecisionTree
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
      results[result] ||= 0
      results[result] += 1
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
  def initialize(options = {})
    @column_index = options[:column_index]
    @value = options[:value]
    @results = options[:results]
    @tb = options[:tb]
    @fb = options[:fb]
  end
end
