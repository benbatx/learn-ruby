words_str = gets().strip()
# output words_str except with the words sorted by
# the number of letters in each word
puts words_str.split(' ').sort_by{|word| word.length}.join(' ')
