require 'bundler'
Bundler.require(:default)

APP_PATH = File.expand_path(File.join(File.dirname(__FILE__), '..'))
RANDOM = Random.new(123)
require 'lightly'
LIGHTLY = Lightly.new

require File.join(APP_PATH, './lib/sample_data.rb')
require File.join(APP_PATH, './lib/problem.rb')

# puts SampleData.new('peter_pan.txt').words
