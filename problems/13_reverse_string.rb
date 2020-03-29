word = gets.strip
# output word reversed

# wasting -> gnitsaw
# whiskers -> sreksihw
# head -> daeh
# remedies -> seidemer
#puts word.reverse
def reverse(word)
  arr = word.split('')
  backword = []
  word.size.times {backword << arr.pop}
  backword.join
end
puts reverse(word)
