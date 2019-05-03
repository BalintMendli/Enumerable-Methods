require './enumerable.rb'

describe Enumerable do
  let(:test_array) { [1, 2, 3] }
  let(:test_hash) {{a:1,b:2,c:3}}
  let(:test_range) { (1..5) }
  let(:test_block) { proc { |i| i * 2 } }

  describe '#my_each' do
    it 'returns original array' do
      expect(test_array.my_each { |n| n*2}).to eq(test_array)
    end

    it 'outputs each element times 2 with Array' do
      expect { test_array.my_each { |n| print n * 2 } }.to output("246").to_stdout
    end

    it 'outputs each element times 2 with Range' do
      expect { test_range.my_each { |n| print n * 2 } }.to output("246810").to_stdout
    end

    it 'outputs each key and value times 2 with Hash' do
      expect { test_hash.my_each { |k,v| print "#{k}: #{2*v}," } }.to output("a: 2,b: 4,c: 6,").to_stdout
    end
  end

  describe '#my_select' do
    it 'returns odd numbers from array' do
      expect(test_array.my_select(&:odd?)).to eq([1,3])
    end
  end
end
