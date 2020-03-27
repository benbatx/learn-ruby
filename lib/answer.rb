require 'shellwords'
class Answer < Struct.new(:before_rb, :ruby_runner, :stdin_data, keyword_init: true)
  def output
    @output ||= begin
      runner_hash = Digest::MD5.file(ruby_runner).hexdigest
      LIGHTLY.get(runner_hash + stdin_data + 'abb') do
        cmd = "BEFORE_RB=#{Shellwords.escape(before_rb)} ruby #{File.expand_path(File.join(APP_PATH, 'lib/caller.rb'))} #{ruby_runner}"
        # puts cmd
        before = Time.now
        _stdout, _status = Open3.capture2e(cmd, stdin_data: stdin_data)
        after = Time.now
        elapsed = after - before
        ret = [_stdout, _status, elapsed]
        return ret unless _status == 0 # no cache
        ret
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
