num = gets.to_i
# output true if num is divisible by 7, otherwise output false
# 
# 2 -> false
# 7 -> true
# 13 -> false
# 49 -> true
divided = num / 7
puts num == divided*7
