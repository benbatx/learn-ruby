require 'bundler'
Bundler.require(:default)

require_relative 'lib/common.rb'
class SelfTest < Problem
  def selftest_dir
    File.join(spec_folder_path, 'should_pass')
  end
  def selftest_rb_paths
    Dir[File.join(selftest_dir, '*.rb')]
  end
  def selftest
    if Dir.exist?(selftest_dir)
      paths = selftest_rb_paths
      # puts "#{self.name} #{paths.count}"
      return unless paths.any?
      paths.each do |stpath|
        cmd = "ruby check.rb #{File.expand_path(stpath)}"
        # puts cmd
        out, status = Open3.capture2e(cmd)
        code = status.exitstatus
        if code != 0
          puts "failed! #{self.name}"
          puts out
          exit(code)
        end
      end
      puts "passed! #{self.name}"
      # if paths.any?
      #   all_passed = paths.all? do |path|
      #     check_solution(ruby_runner: path, silent_pass: true)
      #   end
      #   if all_passed
      #     puts "passed #{name}"
      #   else
      #     puts "failed #{name}"
      #   end
      # end
    else
      FileUtils.mkdir_p(selftest_dir)
    end
  end
end

SelfTest.all.each do |prob|
  prob.selftest
end
