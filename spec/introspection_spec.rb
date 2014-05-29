require_relative 'spec_helper'
require 'introspection'

describe Introspection do
  specify { Introspection.should be_a(Module) }

  specify 'classes that include it get an "introspect" method'  do
    class ClassThatIncludesIntrospection; include Introspection; end
    ClassThatIncludesIntrospection.new.should respond_to(:introspect)
  end

  describe :introspect do
    context 'on classes' do
      before do
        class Foo; include Introspection; end
        @klass = Foo
        @results = @klass.introspect
      end

      it 'gives the object class' do
        @results[@klass].should be
      end

      it 'gives the object heirarchy from the caller up to BasicObject' do
        ancestors = [
          Object,
          Introspection,
          PP::ObjectMixin,
          Kernel,
          BasicObject
        ]

        @results[@klass][:ancestors].should == ancestors
      end
    end

    context 'on instances' do
      before do
        class Foo; include Introspection; end
        @klass = Foo
        @instance = @klass.new
        @results = @instance.introspect
      end

      it 'gives the object class' do
        @results[@instance].should respond_to(:[])
      end

      it 'gives the object heirarchy from the caller up to BasicObject' do
        pending 'functionality currently broken'
        ancestors = [
          Object,
          Introspection,
          PP::ObjectMixin,
          Kernel,
          BasicObject
        ]

        @results[@instance][:ancestors].should == ancestors
      end
    end
  end
end
