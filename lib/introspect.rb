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

module Introspect

  # command handler, this will let me namespace things better later
  def introspect command = nil, opts = nil
    case command
    when :name then self.introspect_name
    when :contents then Contents.contents self, opts
    else Contents.contents self
    end
  end

  def introspect_name
    if self.kind_of? Module
      self.methods(false).include?(:inspect) ? self.name : self
    else
      self
    end
  end
end
