module Internals
  # You can do `Object.send :include, Internals`
  # Then you can call `.contents` on anything.
  #
  # the `contents` method returns a hash with information about the receiver
  # including its Class, the Constants and instance_methods defined inside it.

  def contents(depth = 0)

    if self.kind_of?(Module) && ![Object, Module, Class, BasicObject, Kernel].include?(self)
       @ancestors = self.ancestors

       @constants = []
      self.constants.each do |c|
        c = self.const_get(c)

        if c.respond_to?(:contents) && (depth == 0 || depth > 1) then
          @constants << c.contents(depth == 0 ? 0 : depth - 1)
        else
          @constants << c
        end
      end

      @instance_methods = []
      self.instance_methods(false).each do |m|
        @instance_methods << self.instance_method(m)
      end
    end

    @structure = {self => {:class => self.class}}
    @structure[self][:ancestors] = @ancestors unless @ancestors.nil? || @ancestors.length <= 1
    @structure[self][:constants] = @constants unless @constants.nil? || @constants.empty?
    @structure[self][:instance_methods] = @instance_methods unless @instance_methods.nil? || @instance_methods.empty?

    @structure
  end
end

#Object.send :include, Internals
