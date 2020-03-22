full_name = gets.strip
# full_name = "Ben Barton" #(mentally replace w this!)
# output "Your last name is <last name>!"
# Ben Barton -> Your last name is Barton!
# Elday Kornberg -> Your last name is Kornberg!
# Santa Claus -> Your last name is Claus!
# David Hasselhoff -> Your last name is Hasselhoff!
parts = full_name.split
puts "Your last name is #{parts[parts.length-1]}!"
