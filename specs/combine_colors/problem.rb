colors_str = gets.strip
# colors_str is two primary colors separated by a space (in alphabetical order)
# output the color if these two colors were combined



cols = colors_str.split(' ')
if cols[0] == cols[1]
  puts cols[0]
elsif cols == ['blue', 'yellow']
  puts 'green'
elsif cols == ['blue', 'red']
  puts 'purple'
elsif cols == ['red', 'yellow']
  puts 'orange'
end
