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

  # def initialize(*a, **kw)
  #   @no_passed = 0
  #   super
  # end

end
# puts "checking.."
problem = ProblemChecker.new(name_or_path: problem_name)
ret = problem.check_solution
if ret
  exit(0)
else
  exit(1)
end
