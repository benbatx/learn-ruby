require_relative 'init.rb'
require_relative 'lib/problem.rb'

class ProblemCopier < Problem
  def prompt_lines
    content = File.read(specs_file_path)
    lines = content.split("\n")
    non_comment_lines = 0
    at_begin = true
    second_non_comment_line_no = lines.index do |line|
      if line[0] != '#'
        if at_begin
          at_begin = false
          next false
        end
        next true
      end
      false
    end
    return lines unless second_non_comment_line_no
    lines[0..second_non_comment_line_no - 1]
  end
  def problem_file_contents

    no_examples = 4
    ret_lines = []

    _prompt_lines = prompt_lines
    ret_lines += _prompt_lines
    unless _prompt_lines.any?{|line| line.include?(' -> ')}
      ret_lines += input_content.split("\n")[0..no_examples - 1].map{|line| "# #{line} -> #{our_answer(line)}"}
    end
    ret_lines.join("\n") + "\n" * 3
  end
  def problem_path
    File.join(APP_PATH, 'problems', name + '.rb')
  end
  def identical?
    File.read(problem_path) == problem_file_contents
  end
  def copy
    if File.exist?(problem_path) && !identical?
      rel_path = Pathname.new(problem_path).relative_path_from(Pathname.new(APP_PATH))
      puts "#{rel_path} already exists, overwrite? (y/n)"
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

cmd_name = args[0]
problem_name = args[1]

ProblemCopier.new(problem_name).send(cmd_name)