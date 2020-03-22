name_age = gets.strip
# greet someone with a sentence when they enter their first name and age
# Ben 26 -> Hi Ben! You are 26 years old
# Annabelle 10 -> Hi Annabelle! You are 10 years old
# Grandma 80  -> Hi Grandma! You are 80 years old
arr = name_age.split
puts "Hi #{arr[0]}! You are #{arr[1]} years old"
