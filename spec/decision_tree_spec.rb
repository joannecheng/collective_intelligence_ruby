require_relative '../decision_trees/decision_tree'

fixture = [['slashdot','USA','yes',18,'None'],
             ['google','France','yes',23,'Premium'],
             ['digg','USA','yes',24,'Basic'],
             ['kiwitobes','France','yes',23,'Basic'],
             ['google','UK','no',21,'Premium'],
             ['(direct)','New Zealand','no',12,'None'],
             ['(direct)','UK','no',21,'Basic'],
             ['google','USA','no',24,'Premium'],
             ['slashdot','France','yes',19,'None'],
             ['digg','USA','no',18,'None'],
             ['google','UK','no',18,'None'],
             ['kiwitobes','UK','no',19,'None'],
             ['digg','New Zealand','yes',12,'Basic'],
             ['slashdot','UK','no',21,'None'],
             ['google','UK','yes',18,'Basic'],
             ['kiwitobes','France','yes',19,'Basic']]

describe DecisionNode do
  it 'something'
end

describe DecisionTree do
  describe '#divide_set' do
    it 'divides data into two sets by text' do
      d = DecisionTree.new(fixture)
      column_index = 2
      value = 'yes'

      subscribed = [['slashdot','USA','yes',18,'None'],
             ['google','France','yes',23,'Premium'],
             ['digg','USA','yes',24,'Basic'],
             ['kiwitobes','France','yes',23,'Basic'],
             ['slashdot','France','yes',19,'None'],
             ['digg','New Zealand','yes',12,'Basic'],
             ['google','UK','yes',18,'Basic'],
             ['kiwitobes','France','yes',19,'Basic']]

      unsubscribed = [['google','UK','no',21,'Premium'],
             ['(direct)','New Zealand','no',12,'None'],
             ['(direct)','UK','no',21,'Basic'],
             ['google','USA','no',24,'Premium'],
             ['digg','USA','no',18,'None'],
             ['google','UK','no',18,'None'],
             ['kiwitobes','UK','no',19,'None'],
             ['slashdot','UK','no',21,'None']]

      set1, set2 = d.divide_set(column_index, value)

      expect(set1).to eq subscribed
      expect(set2).to eq unsubscribed
    end

    it 'divides data into two sets by numeric' do
      d = DecisionTree.new(fixture)
      column_index = 3
      value = 20

      over_and_including_20 = [['google','France','yes',23,'Premium'],
             ['digg','USA','yes',24,'Basic'],
             ['kiwitobes','France','yes',23,'Basic'],
             ['google','UK','no',21,'Premium'],
             ['(direct)','UK','no',21,'Basic'],
             ['google','USA','no',24,'Premium'],
             ['slashdot','UK','no',21,'None']]

      under_20 = [['slashdot','USA','yes',18,'None'],
             ['(direct)','New Zealand','no',12,'None'],
             ['slashdot','France','yes',19,'None'],
             ['digg','USA','no',18,'None'],
             ['google','UK','no',18,'None'],
             ['kiwitobes','UK','no',19,'None'],
             ['digg','New Zealand','yes',12,'Basic'],
             ['google','UK','yes',18,'Basic'],
             ['kiwitobes','France','yes',19,'Basic']]

      set1, set2 = d.divide_set(column_index, value)

      expect(set1).to eq over_and_including_20
      expect(set2).to eq under_20
    end
  end

  describe '#unique_counts' do
    it 'creates counts of possible results (last column)' do
      d = DecisionTree.new(fixture)

      counts = d.unique_counts

      expect(counts).to eq({ basic: 6, none: 7, premium: 3 })
    end
  end

  describe '#gini_impurity' do
    it 'calculates gini impurity (expected error rate)' do
      d = DecisionTree.new(fixture)

      gini_impurity = d.gini_impurity

      expect(gini_impurity).to eq 0.6328125
    end
  end

  describe '#entropy' do
    it 'calculates entropy, or how mixed a set is' do
      d = DecisionTree.new(fixture)

      entropy = d.entropy

      expect(entropy).to eq 1.5052408149441479
    end

    it 'calculates entropy on a sub set of data' do
      d = DecisionTree.new(fixture)
      set1, set2 = d.divide_set(2, 'yes')

      entropy = d.entropy(set1)

      expect(entropy).to eq 1.2987949406953985
    end
  end

  describe '.build_tree' do
    it 'returns empty node if length of rows == 0' do
      rows = []
      d = DecisionTree.build_tree(rows)

      expect(d.class).to eq EmptyDecisionNode
    end

    it 'returns a tree' do
      DecisionTree.build_tree(fixture)
    end
  end

end
