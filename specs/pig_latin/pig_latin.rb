word = gets.strip
# output the pig latin version of word
# with these rules: https://web.ics.purdue.edu/~morelanj/RAO/prepare2.html

require 'set'
VOWELS = Set.new('aeiou'.split(''))
def is_vowel?(letter)
  VOWELS.include?(letter)
end

if !is_vowel?(word[0])
  if is_vowel?(word[1])
    puts word[1..-1] + word[0] + 'ay'
  else
    puts word[2..-1] + word[0..1] + 'ay'
  end
else
  puts word + "way"
end
