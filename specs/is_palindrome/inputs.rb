require_relative '../../lib/common.rb'

words = %w{sagas elday ben racecar} + SampleData.new('peter_pan.txt').words(20) + %w{level civic deified lol lool aibohphobia kanakanak}
puts words.join("\n")
