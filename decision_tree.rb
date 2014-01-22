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

  def unique_counts
    results = {}
    @rows.each do |row|
      result = row.last.downcase.to_sym
      results[result] ||= 0
      results[result] += 1
    end
    results
  end

end

class DecisionNode
  def __init__(options)
    @column_index = options[:column_index]
    @value = options[:value]
    @results = options[:results]
    @tb = options[:tb]
    @fb = options[:fb]
  end
end
