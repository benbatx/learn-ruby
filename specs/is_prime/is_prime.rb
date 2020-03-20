number = gets.to_i
# output true if number is prime, otherwise false
# 2 -> true
# 3 -> true
# 4 -> false
# 12 -> false
# 13 -> true

require 'prime'
puts Prime.prime?(number).to_s
