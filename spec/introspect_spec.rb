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
      let(:klass){ class Foo; include Introspect; end }
      let(:instance){ klass.new }
      let(:contents){ instance.introspect }

      it 'gives the object class' do
        contents[instance].should respond_to(:[])
      end

      it 'gives the object heirarchy from the caller up to BasicObject' do
        ancestors = [
          klass,
          Introspect,
          Object,
          PP::ObjectMixin,
          Kernel,
          BasicObject
        ]

        contents[instance][:ancestors].should == ancestors
      end
    end
  end
end
