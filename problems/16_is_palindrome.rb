word = gets.strip
# output true if word is a palindrome, otherwise false

# sagas -> true
# elday -> false
# ben -> false
# racecar -> true
def reverse(word)
  arr = word.split('')
  backword = []
  word.length.times {backword << arr.pop}
  backword.join
end
puts word == reverse(word)
