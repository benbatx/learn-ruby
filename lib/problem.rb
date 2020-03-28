require 'open3'
require 'pathname'

require File.join(APP_PATH, './lib/answer.rb')
class Problem < Struct.new(:path, :name, :no, keyword_init: true)
  # options: timeout, custom
  require_relative './problem/order'
  PROBLEM_SPECS_PATH = File.join(APP_PATH, 'specs')
  PROBLEMS_PATH = File.join(APP_PATH, 'problems')

  def self.path_to_name(path)
    name = File.basename(path)
    name.sub!(/\A\d+_/, '')
    name.sub!(/\.rb\Z/, '')
    name
  end
  def self.name_to_path(name)
    no = ORDER.index(name)
    File.join(PROBLEMS_PATH, "#{no && (no + 1) || '999'}_#{name}.rb")
  end

  def self.from_name(name)
    self.new(self.name_to_path(name))
  end

  def initialize(name_or_path: nil, **kw)
    # name = if File.exist?(_name)
    super(**kw)

    if name_or_path
      if File.exist?(name_or_path)
        kw[:path] = name_or_path
      else
        kw[:name] = name_or_path
      end
    end

    unless kw[:path]
      kw[:path] = File.expand_path(self.class.name_to_path(kw[:name]))
    end
    unless kw[:name]
      kw[:name] = self.class.path_to_name(kw[:path])
    end

    self.no_examples = 4

    kw[:no] = ORDER.index(self.name)

    super(**kw)

    if !name && !path
      debugger
    end

    debugger unless self.name.match(/\A\w+\Z/)

  end

  def self.all
    Dir[File.join(PROBLEM_SPECS_PATH, '*')].map do |path|
      name = path.split('/')[-1]
      self.new(name: name)
    end
  end

  def forbid(methods)
    @forbidden_methods = methods
  end
  attr_accessor :no_examples, :congrats_msg
  # def no_examples=(no)
  #   p no
  #   @no_examples = no
  # end

  # def no
  #   i = ORDER.index(name)
  #   return nil unless i
  #   i + 1
  # end
  def spec_folder_path
    File.join(PROBLEM_SPECS_PATH, name)
  end
  def specs_file_path
    paths = []
    paths << File.join(spec_folder_path, name + '.rb')
    paths << File.join(spec_folder_path, 'problem.rb')
    paths.find{|path| File.exist?(path)} || paths[0]
  end
  def problem_path; path; end
  def static_input_path
    File.join(spec_folder_path, 'inputs.txt')
  end
  def gen_input_path
    File.join(spec_folder_path, 'inputs.rb')
  end
  def problem_rel_path
    Pathname.new(problem_path).relative_path_from(Pathname.new(APP_PATH))
  end
  def content
    return nil unless File.exist?(problem_path)
    @content ||= File.read(problem_path)
  end

  def input_content
    prompt_lines
    return @input_content if @input_content
    unless File.exist?(static_input_path) && File.read(static_input_path).strip != ''
      raise "expected generator #{gen_input_path.inspect}" unless File.exist?(gen_input_path)
      result = `ruby #{gen_input_path}`
      File.write(static_input_path, result)
    end
    @input_content = File.read(static_input_path)
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
  def our_answer(line)
    Answer.new(ruby_runner: specs_file_path, stdin_data: line)
  end
  def spec
    @spec ||= ProblemSpec.new(path: specs_file_path)
  end
  def prompt_lines
    @prompt_lines ||= begin
      content = File.read(specs_file_path)
      lines = content.split("\n")
      prompt_lines_n = lines.index do |line|
        next false if line[0] == '#'
        next false if line.include?('gets')
        next true
        # if line[0] != '#'
        #   unless line.include?('gets')
        #     next false
        #   end
        #   next true
        # end
        # false
      end

      prompt_lines = if prompt_lines_n
        lines[0..prompt_lines_n - 1]
      else
        lines
      end
      # last_evaled_line_no = nil
      # prompt_lines.each.with_index do |line, i|
      #   next false unless line.start_with?('#')
      #   # next false if line.match(/\A\d+\Z/)
      #   # next false if line.match(/\A\d+.+\Z/)
      #   rb = line.sub(/\A#/, '')
      #   res = begin
      #     eval(rb)
      #     previous_eval = last_evaled_line_no
      #     last_evaled_line_no = i
      #   rescue Exception => ee
      #     break if previous_eval
      #     # puts "problem-rb #{ee.full_message}"
      #   end
      #   # puts "#{rb} -> #{res.inspect}"
      #   res
      # end
      settings_i = prompt_lines.index('# settings')
      if settings_i
        # settings_i += 1

        settings_lines = prompt_lines[settings_i..-1]
        prompt_lines -= settings_lines

        settings_lines.each do |line|
          rb = line.sub(/\A#/, '')
          res = begin
            eval(rb)
          rescue Exception => ee
          end
        end
      end
      prompt_lines
    end

  end

  def inputs
    if block_given?
      @input_content = yield
    end
    input_content.split("\n")
  end

  def check_solution(ruby_runner: problem_path, silent_pass: false)
    @no_passed = 0
    inputs.each.with_index do |line, i|
      puts "checking #{i + 1}" unless silent_pass
      actual = Answer.new(ruby_runner: ruby_runner, stdin_data: line, before_rb: before_rb)
      expected = our_answer(line)
      if actual.stdout.strip != expected.stdout.strip
        # puts "echo #{line} | ruby problems/#{name}.rb"
        puts "#{@no_passed} tests passed!" if @no_passed >= 1

        # puts "ruby #{problem_rel_path}"
        puts "input    : #{line}"
        puts "expected : #{expected.stdout.strip.count("\n") > 0 ? "\n" : ''}#{expected.stdout}"
        puts "but got  : #{actual.stdout.strip.count("\n") > 0 ? "\n" : ''}#{actual.stdout}"

        return false
      end
      runtime_ratio = actual.runtime / expected.runtime

      if runtime_ratio > 1.5
        puts "#{@no_passed} tests passed!"

        puts "input    : #{line}"
        pct_slower = ((runtime_ratio - 1.0) * 100).to_i
        puts "too slow! (#{pct_slower}% slower)"
        return false
      end
      @no_passed += 1
    end
    unless silent_pass
      puts "#{@no_passed} tests passed!"
      puts "everything looks good! 🌈☀️"
      if congrats_msg
        puts ""
        puts congrats_msg
        puts ""
      end
    end
    return true
  end

end
