require_relative File.join('..', '..', 'init.rb')

words = %w{sagas elday ben racecar} + SampleData.new('peter_pan.txt').sample_words(20) + %w{level civic deified lol lool aibohphobia kanakanak}
puts words.join("\n")
