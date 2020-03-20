require 'open3'
require 'pathname'

class Problem < Struct.new(:name)
  ORDER = [
    'rock_paper_scissors', # boolean logic
    'count_words', # String#split
    'hi_birthday', # String#split, interpolation
    'hi_birthday2', # String#split, interpolation, String#to_i
    'count_vowels', # Array#count
    'reverse_string', # loops, arrays
    'check_duplicates', # Array#count, loop
    'pig_latin', # boolean logic, string slicing
    'is_palindrome',
    'num_digits', # Number#to_s
    'is_divisible', # modulo
    'is_prime', # modulo, functions
  ]
  PROBLEM_SPECS_PATH = File.join(APP_PATH, 'specs')
  PROBLEMS_PATH = File.join(APP_PATH, 'problems')

  def self.all
    Dir[File.join(PROBLEM_SPECS_PATH, '*')].map do |path|
      name = path.split('/')[-1]
      self.new(name)
    end
  end
  def no
    i = ORDER.index(name)
    return 0 unless i
    i + 1
  end
  def specs_folder_path
    File.join(PROBLEM_SPECS_PATH, name)
  end
  def specs_file_path
    File.join(specs_folder_path, name + '.rb')
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
  # def file_path
  #   File.join(PROBLEMS_PATH, name + '.rb')
  # end
  def content
    return nil unless File.exist?(problem_path)
    @content ||= File.read(problem_path)
  end

  def input_content
    unless File.exist?(static_input_path) && File.read(static_input_path).strip != ''
      raise "expected generator #{gen_input_path}" unless File.exist?(gen_input_path)
      result = `ruby #{gen_input_path}`
      File.write(static_input_path, result)
    end
    File.read(static_input_path)
  end

  def our_answer(line)
    our_stdout, our_status = LIGHTLY.get(our_hash + line) { Open3.capture2("ruby #{specs_file_path}", stdin_data: line) }
    if our_status != 0
      raise "error, ask Ben :P"
      return
    end
    our_stdout.strip
  end
  def their_answer(line)
    their_stdout, their_status = LIGHTLY.get(their_hash + line) { Open3.capture2("ruby #{problem_path}", stdin_data: line) }
    their_stdout.strip
  end

  def their_hash
    @their_hash ||= Digest::MD5.file(problem_path).hexdigest
  end
  def our_hash
    @our_hash ||= Digest::MD5.file(specs_file_path).hexdigest
  end
end
