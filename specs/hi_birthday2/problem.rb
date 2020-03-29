name_age = gets.strip
# greet someone with a different sentence when they enter their first name and birthday
name, age = name_age.split(' ')
puts "Hi #{name}! #{100 - age.to_i} years until your 100th birthday"
