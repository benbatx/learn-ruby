require_relative File.join('..', '..', 'init.rb')
require File.join(APP_PATH, 'lib/data.rb')

puts Data.words('alice.txt')
