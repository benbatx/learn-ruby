# problem_paths = Dir[File.join(File.dirname(__FILE__), 'problem_specs/*')]
# problem_paths.each do |path|
#   problem_name = path.split('/')[-1]
#   puts problem_name
# end

problem_name = ARGV[0]

unless problem_name
  puts "usage: "
  puts "ruby #{File.basename(__FILE__)}.rb <problem_name>"
end

require_relative 'init.rb'
require_relative 'lib/problem.rb'
class ProblemChecker < Problem

  def check_solution
    input_content.split("\n").each do |line|
      # puts "checking #{line}"
      # their_stdout, their_status = LIGHTLY.get(their_hash + line) { Open3.capture2("ruby #{file_path}", stdin_data: line) }
      actual = their_answer(line)
      expected = our_answer(line)
      if actual != expected
        # puts "echo #{line} | ruby problems/#{name}.rb"
        puts "oops?"
        puts "ruby problems/#{name}.rb"
        puts "input    : #{line}"#line.inspect
        puts "output   : #{actual}"
        puts "expected : #{expected}"
        # puts "#{line} shouldn't be #{their_stdout}"
        return
      end
      # next if their_answer == our_answer
      # puts "Wrong answer for #{line.inspect}"
    end
    puts "everything looks good! 🌈☀️"
  end
end
puts "checking.."
problem = ProblemChecker.new(problem_name)
problem.check_solution
problem
