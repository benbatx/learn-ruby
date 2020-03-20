str = gets.strip
# output true if str has any word more than once
words = str.split(" ")
puts words.uniq.length == words.length
