$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'bundler'
Bundler.require(:test)

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def run(*args)
  output = Struct.new(:pid, :stdout, :stderr)

  status = Open4.popen4(*args) do |pid, stdin, stdout, stderr|
    output = output.new pid, stdout.read, stderr.read
  end

  [status, output]
end
