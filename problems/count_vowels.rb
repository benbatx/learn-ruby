word = gets.strip
# output the number of vowels in word
# elday -> 2
# ben -> 1
# covidsucks -> 3
sum = 0
'aeiou'.split('').each do |vowel|
  sum += word.count(vowel)
end
puts sum
