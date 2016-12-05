#
# You can do `Object.send :include, Introspect`
# Then you can call `.introspect` on anything.
#
# The `introspect` method returns a hash with information about the receiver
# including its Class, the Constants, methods, and instance_methods defined inside it.
#
# The "depth" parameter indicates how deeply it should inspect the object.
# By default there is no depth limit. Pass in 1 to just get info on the object itself.
#

require 'introspect/version'
require 'introspect/contents'
require 'introspect/which'

module Introspect
  def self.introspect obj, command = nil, opts = nil
    case command
    when :which then Introspect::Which.which obj, opts
    when :contents then  Introspect::Contents.contents obj, opts
    else
      raise ArgumentError, "unrecognized command: #{command}"
    end
  end

  def introspect command = nil, opts = nil
    Introspect.introspect self, command, opts
  end
end
