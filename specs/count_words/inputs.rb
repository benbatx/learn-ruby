require_relative File.join('..', '..', 'init.rb')

puts SampleData.new('alice.txt').sample_sentences.select{|sentence| sentence.split(" ").length <= 10}
