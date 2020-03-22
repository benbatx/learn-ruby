name_age = gets.strip
# greet someone with a different sentence when they enter their first name and birthday
# Ben 26 -> Hi Ben! 74 years until your 100th birthday
# Annabelle 10 -> Hi Annabelle! 90 years until your 100th birthday
# Grandma 80  -> Hi Grandma! 20 years until your 100th birthday
arr = name_age.split
puts "Hi #{arr[0]}! #{100-arr[1].to_i} years until your 100th birthday"
