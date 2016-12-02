module Introspect
  module Which
    def which method_name
      ometh = proc { |obj,sym| return obj if obj.methods(false).include? sym }
      imeth = proc { |obj,sym| return obj if obj.instance_methods(false).include? sym }

      # first check the eigenclass
      imeth[(class << self; self; end),method_name]

      obj = self.is_a?(::Module) ? self : self.class

      # then we check the normal class heirarchy
      obj.ancestors.each.with_object method_name, &imeth
      # check the metaclasses
      obj.class.ancestors.each.with_object method_name, &ometh
      obj.class.ancestors.each.with_object method_name, &imeth

      nil
    end
  end
end
