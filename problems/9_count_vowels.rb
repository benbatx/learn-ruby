word = gets.strip
# output the number of vowels in word
# elday -> 2
# ben -> 1
# covidsucks -> 3
#loop, +=, count
letters = word.split('')
vowels = "aeiou".split('')
total_vowels = 0
vowels.each do |vowel|
  total_vowels += letters.count(vowel)
end
puts(total_vowels)
