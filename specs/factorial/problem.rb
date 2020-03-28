n = gets().to_i()
# output n factorial
# no_examples = 6

def factorial(i)
  return 1 if i == 0
  return i * factorial(i - 1)
end
puts factorial(n)
