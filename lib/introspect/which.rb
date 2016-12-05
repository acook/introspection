module Introspect
  class Which
    def self.which object, method_name
      self.new(object).which method_name
    end

    def initialize object
      @object = object
    end

    def which method_name
      ometh = proc { |obj,sym| return obj if obj.methods(false).include? sym }
      imeth = proc { |obj,sym| return obj if obj.instance_methods(false).include? sym }

      begin
        # first check the eigenclass
        imeth[(class << @object; self; end),method_name]
      rescue TypeError => err
        raise unless err.message.include? 'singleton'
      end

      obj = @object.is_a?(::Module) ? @object : @object.class

      # then we check the normal class heirarchy
      obj.ancestors.each.with_object method_name, &imeth
      # check the metaclasses
      obj.class.ancestors.each.with_object method_name, &ometh
      obj.class.ancestors.each.with_object method_name, &imeth

      nil
    end
  end
end
