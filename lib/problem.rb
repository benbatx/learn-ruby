require 'open3'
require 'pathname'

require File.join(APP_PATH, './lib/answer.rb')
class Problem < Struct.new(:name)
  # options: timeout, custom
  require_relative './problem/order'
  PROBLEM_SPECS_PATH = File.join(APP_PATH, 'specs')
  PROBLEMS_PATH = File.join(APP_PATH, 'problems')

  def initialize(_name)
    name = _name.dup
    name.sub!('problems/', '')
    name.sub!(/\A\d+_/, '')
    name.sub!(/\.rb\Z/, '')
    super(name)
  end

  def self.all
    Dir[File.join(PROBLEM_SPECS_PATH, '*')].map do |path|
      name = path.split('/')[-1]
      self.new(name)
    end
  end

  def forbid(methods)
    @forbidden_methods = methods
  end

  def no
    i = ORDER.index(name)
    return nil unless i
    i + 1
  end
  def specs_folder_path
    File.join(PROBLEM_SPECS_PATH, name)
  end
  def specs_file_path
    paths = []
    paths << File.join(specs_folder_path, name + '.rb')
    paths << File.join(specs_folder_path, 'problem.rb')
    paths.find{|path| File.exist?(path)} || paths[0]
  end
  def static_input_path
    File.join(specs_folder_path, 'inputs.txt')
  end
  def gen_input_path
    File.join(specs_folder_path, 'inputs.rb')
  end
  def problem_path
    File.join(PROBLEMS_PATH, "#{no}_#{name}.rb")
  end
  def problem_rel_path
    Pathname.new(problem_path).relative_path_from(Pathname.new(APP_PATH))
  end
  # def file_path
  #   File.join(PROBLEMS_PATH, name + '.rb')
  # end
  def content
    return nil unless File.exist?(problem_path)
    @content ||= File.read(problem_path)
  end

  def input_content
    unless File.exist?(static_input_path) && File.read(static_input_path).strip != ''
      raise "expected generator #{gen_input_path.inspect}" unless File.exist?(gen_input_path)
      result = `ruby #{gen_input_path}`
      File.write(static_input_path, result)
    end
    File.read(static_input_path)
  end

  def our_answer(line)
    Answer.new(ruby_runner: specs_file_path, stdin_data: line)
  end
  def before_rb
    prompt_lines
    return nil unless @forbidden_methods
    @forbidden_methods.map do |_method|
      klass, method = _method.split('#')
      # "#{klass}.undef_method(:#{method})"
      "class #{klass}; def #{method}(*a,**kw); raise '#{name} forbids #{_method}'; end; end"
    end.join(';')
  end
  def their_answer(line)
    Answer.new(ruby_runner: problem_path, stdin_data: line, before_rb: before_rb)
  end
  def spec
    @spec ||= ProblemSpec.new(path: specs_file_path)
  end
  def prompt_lines
    @prompt_lines ||= begin
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

      prompt_lines = if second_non_comment_line_no
        lines[0..second_non_comment_line_no - 1]
      else
        lines
      end

      evaled_lines = prompt_lines.select{|line| line.start_with?('#')}.select do |line|
        rb = line.sub(/\A#/, '')
        begin
          eval(rb)
          true
        rescue Exception => ee
          false
        end
      end
      prompt_lines - evaled_lines
    end

  end

end
