require_relative '../../lib/common.rb'

puts SampleData.new('alice.txt').sentences.select{|sentence| sentence.split(" ").length <= 10}
