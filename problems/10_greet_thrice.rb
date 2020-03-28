name = gets().strip()
# greet name three times (use a loop!)
# hint: 5.times { |num| puts "its time no#{num}" }

# puddlecreature -> hi puddlecreature, bye puddlecreature
# hi puddlecreature, bye puddlecreature
# hi puddlecreature, bye puddlecreature

# elday -> hi elday, bye elday
# hi elday, bye elday
# hi elday, bye elday

# nutmeg -> hi nutmeg, bye nutmeg
# hi nutmeg, bye nutmeg
# hi nutmeg, bye nutmeg}
x = 0
loop do
  x += 1
  puts "hi #{name}, bye #{name}"
  break if x >= 3
end
