number = gets.to_i
# output true if natural number num is prime, otherwise false
# 2 -> true
# 3 -> true
# 4 -> false
# 12 -> false
# 13 -> true
arr = (1..number).select {|n| number % n ==0}
puts arr.size == 2


#def is_prime
