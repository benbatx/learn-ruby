require_relative '../../lib/common.rb'

sd = SampleData.new('words.txt')
[5,5,10].each do |count|
  puts sd.distinct_len_words(count).join(' ')
end
