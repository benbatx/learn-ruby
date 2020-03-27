word = gets.strip
# output the pig latin version of word
# with these rules: https://web.ics.purdue.edu/~morelanj/RAO/prepare2.html

# happy -> appyhay
# child -> ildchay
# awesome -> awesomeway
# with -> ithway
vowels = "aeiou".split('')
#vowels.each do |vowel|
  # if word[0] ==
  #   word << "way"
  #   puts word
  # elsif word[1].count(vowel) == 1
  #   word << word[0] << "ay"
  #   word.delete_at(0)
  #   puts word
  # else
  #   word << word[0..1] << "ay"
  #   word.delete_at(0..1)
  # end
#end
#puts vowels.count(word[0]) == 1
if vowels.include?(word[0]) #first letter is a vowel
  puts word+"way"
elsif vowels.include?(word[1])
  word = word[1..-1]+word[0]+"ay"
  #word[0] = ""
  puts word
else
  word = word[2..-1]+word[0..1]+"ay"
  #word[0..1] = ""
  puts word
end
