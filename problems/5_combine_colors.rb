colors_str = gets.strip
# colors_str is two primary colors separated by a space (in alphabetical order)
# output the color if these two colors were combined
# red yellow -> orange
# blue yellow -> green
# blue red -> purple
# yellow yellow -> yellow
if colors_str == "red yellow" #if not alphabetical: || colors_str == "yellow red"
  puts "orange"
elsif colors_str == "blue yellow"
  puts "green"
elsif colors_str == "blue red"
  puts "purple"
elsif colors_str == "yellow yellow"
  puts "yellow"
elsif colors_str == "blue blue"
  puts "blue"
elsif colors_str == "red red"
  puts "red"
end
