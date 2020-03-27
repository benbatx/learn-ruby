rb = ENV['BEFORE_RB']&.strip
unless [nil, ''].include?(rb)
  eval(rb)
end
target = ARGV[0]
require target
