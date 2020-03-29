require_relative 'lib/common.rb'

class ProblemCopier < Problem
  # def initialize(*a,**kw)
  #   super
  #   puts "#{self.name} missing order" unless self.no
  # end
  def problem_file_contents
    ret_lines = []

    _prompt_lines = prompt_lines
    ret_lines += _prompt_lines
    unless _prompt_lines.any?{|line| line.include?(' -> ')}
      ret_lines += ['# ']
      ret_lines += input_content.split("\n")[0..no_examples - 1].map do |line|
        ours_lines = our_answer(line).stdout.split("\n")
        ours_multiline = (ours_lines.length > 1)
        ret = "# #{line} -> #{ours_lines.join("\n# ")}"
        # ret += "# " if ours_multiline
        ret
      end
    end
    ret_lines.join("\n") + "\n" * 3
  end
  def identical?
    File.read(problem_path) == problem_file_contents
  end
  def copy
    min_no = 15
    if no && no < min_no
      puts "skipping copy with no = #{no} (skip under #{min_no})"
      return
    end
    if File.exist?(problem_path) && !identical?
      puts "#{problem_rel_path} already exists, overwrite? (y/n)"
      return unless STDIN.gets.strip == 'y'
    end
    # gen_input
    # File.open(problem_path, 'w') do |file|
    File.write(problem_path, problem_file_contents)
    # end
  end
end

require 'bundler'
Bundler.require(:default)

# opts = Slop.parse ARGV do |o|
# end
# args = opts.arguments
args = ARGV

# cmd_name = args[0]
cmd_name = 'copy'
problem_name = args[0]

if [nil, 'all'].include?( problem_name )

  Problem.unregistered_problem_paths.each do |unreg|
    puts "removing unregistered path #{unreg}"
    FileUtils.rm(unreg)
  end

  # FileUtils.rm_rf(Problem::PROBLEMS_PATH)
  # FileUtils.mkdir_p(Problem::PROBLEMS_PATH)
  ProblemCopier.all.each do |problem|
    next unless File.exist?(problem.specs_file_path)
    problem.send(cmd_name)
  end
else
  prob = ProblemCopier.new(name: problem_name)
  prob.send(cmd_name)
  `open #{prob.problem_path}`
end
