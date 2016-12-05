require 'bundler/setup'
require 'introspect/core_ext'

module Introspect::CLI
  def self.start file
    load file unless file.nil?

    begin
      require 'pry'
      Pry.start
    rescue LoadError
      require 'irb'
      IRB.start
    end
  end
end
