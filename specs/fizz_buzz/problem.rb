# Write a program that prints the integers from 1 to 100
# But for multiples of 3 print "Fizz" instead of the number
# and for the multiples of 5 print "Buzz"
# For numbers which are multiples of both 3 and 5 print "FizzBuzz"
# -> 1
# 2
# Fizz
# 4
# Buzz
# Fizz
# 7
# 8
# settings
# self.no_examples = 0
# self.inputs { "yo\n" * 10 }
# self.congrats_msg = "Fun fact: this was the interview question for my first full time job!"
(1..100).each do |i|
  if i % 3 == 0 && i % 5 == 0
    puts 'FizzBuzz'
  elsif i % 3 == 0
    puts 'Fizz'
  elsif i % 5 == 0
    puts 'Buzz'
  else
    puts i
  end
end
