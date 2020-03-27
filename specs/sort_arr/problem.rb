words = STDIN.gets().strip().split(" ")
# sort an array of words without using the built in .sort function
# ex:
# jean shorts look quite nice on elday -> elday jean look nice on quite shorts
# she is a damn cute girl -> a cute damn girl is she
# forbid %w{Array#sort Array#sort! Array#sort_by Array#sort_by!}

loop do
  i = 0
  is_sorted = true
  loop do
    break if i + 1 >= words.length
    a = words[i]
    b = words[i + 1]
    if a > b
      is_sorted = false
      words[i + 1] = a
      words[i] = b
    end
    i += 1
  end
  break if is_sorted
end

puts words.join(" ")
