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

require_relative 'lib/common.rb'

class ProblemChecker < Problem

  def initialize(*a, **kw)
    @no_passed = 0
    super
  end

  def check_solution
    input_content.split("\n").each.with_index do |line, i|
      puts "checking #{i}"
      actual = their_answer(line)
      expected = our_answer(line)
      if actual.stdout != expected.stdout
        # puts "echo #{line} | ruby problems/#{name}.rb"
        puts "#{@no_passed} tests passed!"

        # puts "ruby #{problem_rel_path}"
        puts "input    : #{line}"
        puts "expected : #{expected.stdout}"
        puts "but got  : #{actual.stdout}"
        # puts "#{line} shouldn't be #{their_stdout}"
        return
      end
      runtime_ratio = actual.runtime / expected.runtime
      # puts runtime_ratio
      if runtime_ratio > 1.5
        puts "#{@no_passed} tests passed!"

        puts "input    : #{line}"
        pct_slower = ((runtime_ratio - 1.0) * 100).to_i
        puts "too slow! (#{pct_slower}% slower)"
        return
      end
      @no_passed += 1
      # next if their_answer == our_answer
      # puts "Wrong answer for #{line.inspect}"
    end
    puts "#{@no_passed} tests passed!"
    puts "everything looks good! 🌈☀️"
  end
end
# puts "checking.."
problem = ProblemChecker.new(problem_name)
problem.check_solution
problem
