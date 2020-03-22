names_str = gets.strip
# names_str is a string with multiple names.
# say hi & goodbye to each name :)
# hint: 5.times { |num| puts "its time no#{num}" }

names_arr = names_str.split(' ')
names_arr.each do |name|
  puts "hi #{name}, bye #{name}"
end
