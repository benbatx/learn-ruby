n = gets().to_i()
# output the n'th term of the fibonacci sequence
# self.no_examples = 5
def fibonacci(i)
  return 0 if i == 0
  return 1 if i == 1
  return fibonacci(i - 2) + fibonacci(i - 1)
end
puts fibonacci(n)
