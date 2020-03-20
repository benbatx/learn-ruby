require 'open3'
require 'pathname'

class Problem < Struct.new(:name)
  PROBLEM_SPECS_PATH = File.join(APP_PATH, 'specs')
  PROBLEMS_PATH = File.join(APP_PATH, 'problems')

  def self.all
    Dir[File.join(PROBLEM_SPECS_PATH, '*')].map do |path|
      name = path.split('/')[-1]
      self.new(name)
    end
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
  def file_path
    File.join(PROBLEMS_PATH, name + '.rb')
  end
  def content
    return nil unless File.exist?(file_path)
    @content ||= File.read(file_path)
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
    their_stdout, their_status = LIGHTLY.get(their_hash + line) { Open3.capture2("ruby #{file_path}", stdin_data: line) }
    their_stdout.strip
  end

  def their_hash
    @their_hash ||= Digest::MD5.file(file_path).hexdigest
  end
  def our_hash
    @our_hash ||= Digest::MD5.file(specs_file_path).hexdigest
  end
end
