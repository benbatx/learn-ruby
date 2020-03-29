num = gets.to_i
# output true if natural number num has any digits that are even, otherwise false
# 
# 7 -> false
# 12 -> true
# 33577 -> false
# 9150 -> true
number = num.to_s
def is_even?(number)
  evens = "02468".split('')
  evens.include?(number)
end
count = number.length.to_s
puts is_even?(count[-1])
#didn't pass check - input:7  expected:true  but got:false ??
