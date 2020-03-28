rb = ENV['BEFORE_RB']&.strip
unless [nil, ''].include?(rb)
  eval(rb)
end
target = ARGV[0]
def gets
  STDIN.gets
end
contents = File.read(target)
instance_eval(contents, target)
