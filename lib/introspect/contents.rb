class Introspect::Contents
  def self.contents object, arg = nil
    self.new(object).contents arg
  end

  def initialize object
    @object = object
  end

  def contents depth = 0
    depth = 0 if depth.nil?

    if @object.kind_of?(Module) && ![Object, Module, Class, BasicObject, Kernel].include?(@object)
      @ancestors = @object.ancestors
      @ancestors.shift

      @constants = []
      @object.constants.sort.each do |c|
        object = @object.const_get(c)

        if object.respond_to?(:contents) && (depth == 0 || depth > 1) then
          @constants << object.contents(depth == 0 ? 0 : depth - 1)
        else
          @constants << nameof(object)
        end
      end

      @methods = []
      @object.methods(false).each do |m|
        @methods << @object.method(m)
      end

      @instance_methods = []
      @object.instance_methods(false).each do |m|
        @instance_methods << @object.instance_method(m)
      end
    else
      @ancestors = @object.class.ancestors
    end

    structure = Hash.new
    structure[:class] = @object.class
    structure[:ancestors] = @ancestors unless @ancestors.nil? || @ancestors.empty?
    structure[:constants] = @constants unless @constants.nil? || @constants.empty?
    structure[:methods] = @methods unless @methods.nil? || @methods.empty?
    structure[:instance_methods] = @instance_methods unless @instance_methods.nil? || @instance_methods.empty?

    {nameof(@object) => structure}
  end

  def nameof obj
    if obj.kind_of? Module
      obj.methods(false).include?(:inspect) ? obj.name : obj
    else
      obj
    end
  end
end
