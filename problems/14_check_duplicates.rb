str = gets.strip
# output true if str has any word more than once

# i ate some pancakes -> true
# the fox jumped over the moon -> false
# elday has magic hands -> true
# boys will be boys -> false
arr = str.split(' ')
if arr.uniq.length == arr.length
  puts "true"
else
  puts "false"
end
