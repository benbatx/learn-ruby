require_relative '../../lib/common.rb'

puts "beta gamma omega alpha"
puts "jean shorts look quite nice on eleanor-day"
sd = SampleData.new('words.txt')
[10, 50, 100, 100, 1000, 5 * 1000].each do |wc|
  puts sd.words(wc).join(" ")
end
