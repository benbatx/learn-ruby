num = gets.to_i
# output true if natural number num has any digits that are even
puts num.to_s.split(' ').any?{|digit_s| digit_s.to_i % 2 == 0 }
