require_relative 'spec_helper'
require 'introspect'

describe Introspect do
  specify { Introspect.should be_a(Module) }

  specify 'classes that include it get an "introspect" method'  do
    class ClassThatIncludesIntrospect; include Introspect; end
    ClassThatIncludesIntrospect.new.should respond_to(:introspect)
  end

  describe :introspect do
    context 'on classes' do
      before do
        class Foo; extend Introspect; end
        @klass = Foo
        @results = @klass.introspect
      end

      it 'gives the object class' do
        @results[@klass].should be
      end

      it 'gives the object heirarchy from the caller up to BasicObject' do
        ancestors = [
          Object,
          PP::ObjectMixin,
          Kernel,
          BasicObject
        ]

        @results[@klass][:ancestors].should == ancestors
      end
    end

    context 'on instances' do
      before do
        class Foo; include Introspect; end
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
          Introspect,
          PP::ObjectMixin,
          Kernel,
          BasicObject
        ]

        @results[@instance][:ancestors].should == ancestors
      end
    end
  end
end
