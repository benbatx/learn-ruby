class Answer < Struct.new(:problem, :ruby_runner, :salt, :stdin_data, keyword_init: true)
  # runtime
  def output
    @output ||= begin
      runner_hash = Digest::MD5.file(ruby_runner).hexdigest
      LIGHTLY.get(runner_hash + stdin_data + salt.to_s + 'g') do
        before = Time.now
        _stdout, _status = Open3.capture2("ruby #{ruby_runner}", stdin_data: stdin_data)
        after = Time.now
        elapsed = after - before
        [_stdout, _status, elapsed]
      end
    end
  end
  def runtime
    output[2]
  end
  def stdout
    output[0]
  end
end
