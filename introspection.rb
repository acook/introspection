#
# You can do `Object.send :include, Introspection`
# Then you can call `.introspect` on anything.
#
# The `introspect` method returns a hash with information about the receiver
# including its Class, the Constants and instance_methods defined inside it.
#
# The "depth" parameter indicates how deeply it should inspect the object.
# By default there is no depth limit. Pass in 1 to just get info on the object itself.
#
module Introspection
  def introspect depth = 0

    if self.kind_of?(Module) && ![Object, Module, Class, BasicObject, Kernel].include?(self)
      @ancestors = self.ancestors

      @constants = []
      self.constants.sort.each do |c|
        object = self.const_get(c)

        if object.respond_to?(:contents) && (depth == 0 || depth > 1) then
          @constants << object.contents(depth == 0 ? 0 : depth - 1)
        else
          @constants << object.introspect_name
        end
      end

      @instance_methods = []
      self.instance_methods(false).each do |m|
        @instance_methods << self.instance_method(m)
      end
    end

    structure = Hash.new
    structure[:class] = self.class
    structure[:ancestors] = @ancestors unless @ancestors.nil? || @ancestors.length <= 1
    structure[:constants] = @constants unless @constants.nil? || @constants.empty?
    structure[:instance_methods] = @instance_methods unless @instance_methods.nil? || @instance_methods.empty?

    {self.introspect_name => structure}
  end

  def introspect_name
    if self.kind_of? Module
      self.methods(false).include?(:inspect) ? self.name : self
    else
      self
    end
  end
end

Object.send :include, Introspection
