require_relative '../../lib/common.rb'
require File.join(APP_PATH, 'lib/data.rb')

puts Data.words('alice.txt')
