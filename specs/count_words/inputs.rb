require_relative '../../lib/common.rb'

puts SampleData.new('alice.txt').sample_sentences.select{|sentence| sentence.split(" ").length <= 10}
