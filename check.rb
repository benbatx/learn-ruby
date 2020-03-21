# problem_paths = Dir[File.join(File.dirname(__FILE__), 'problem_specs/*')]
# problem_paths.each do |path|
#   problem_name = path.split('/')[-1]
#   puts problem_name
# end

problem_name = ARGV[0].dup

unless problem_name
  puts "usage: "
  puts "ruby #{File.basename(__FILE__)}.rb <problem_name>"
end

problem_name.sub!('problems/', '')
problem_name.sub!(/\A\d+_/, '')
problem_name.sub!(/\.rb\Z/, '')

require_relative 'init.rb'
require_relative 'lib/problem.rb'
class ProblemChecker < Problem

  def check_solution
    no_passed = 0
    input_content.split("\n").each do |line|
      # puts "checking #{line}"
      # their_stdout, their_status = LIGHTLY.get(their_hash + line) { Open3.capture2("ruby #{file_path}", stdin_data: line) }
      actual = their_answer(line)
      expected = our_answer(line)
      if actual != expected
        # puts "echo #{line} | ruby problems/#{name}.rb"
        puts "#{no_passed} tests passed!"

        puts "ruby #{problem_rel_path}"
        puts "input    : #{line}"#line.inspect
        puts "expected : #{expected}"
        puts "but got  : #{actual}"
        # puts "#{line} shouldn't be #{their_stdout}"
        return
      end
      no_passed += 1
      # next if their_answer == our_answer
      # puts "Wrong answer for #{line.inspect}"
    end
    puts "#{no_passed} tests passed!"
    puts "everything looks good! 🌈☀️"
  end
end
puts "checking.."
problem = ProblemChecker.new(problem_name)
problem.check_solution
problem
