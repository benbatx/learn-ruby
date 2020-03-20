word = gets.strip
# output the number of vowels in word
# elday -> 2
# ben -> 1
# covidsucks -> 3
occurrences = word.split('').tally
sum = 0
'aeiou'.split('').each do |vowel|
  sum += occurrences[vowel] || 0
end
puts sum
