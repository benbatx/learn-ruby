names_str = gets.strip
# names_str is a string with multiple names.
# say hi & goodbye to each name :)

# rain wind snow thunder -> hi rain, bye rain
# hi wind, bye wind
# hi snow, bye snow
# hi thunder, bye thunder

# elday nutmeg ben puddlecreature -> hi elday, bye elday
# hi nutmeg, bye nutmeg
# hi ben, bye ben
# hi puddlecreature, bye puddlecreature

# moon mars sky stars -> hi moon, bye moon
# hi mars, bye mars
# hi sky, bye sky
# hi stars, bye stars
arr = names_str.split(' ')
arr_length = arr.length
x=0
loop do
  puts "hi #{arr[x]}, bye #{arr[x]}"
  x += 1
  break if x >= arr_length.to_i
end
