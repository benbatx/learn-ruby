move = gets().strip() #functions - always give back a string
# output the move that wins the rock paper scissors game

# rock -> paper
# paper -> scissors
# scissors -> rock
if false #independent if statements
  if move == "rock"
    puts "paper"
  end
  if move == "paper"
    puts "scissors"
  end
  if move == "scissors"
    puts "rock"
  end
end
if move == "rock" #dependent
  puts "paper"
elsif move == "paper"
  puts "scissors"
elsif move == "scissors"
  puts "rock"
end
