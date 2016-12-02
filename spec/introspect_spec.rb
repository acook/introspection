require_relative 'spec_helper'
require 'introspect'

describe Introspect do
  specify { expect(Introspect).to be_a Module }

  specify 'classes that include it get an "introspect" method'  do
    class ClassThatIncludesIntrospect; include Introspect; end
    expect(ClassThatIncludesIntrospect.new).to respond_to :introspect
  end

  describe :introspect do
    context 'on classes' do
      let(:klass){ class Foo; extend Introspect; end }
      let(:contents){ klass.introspect }

      it 'gives the object class' do
        expect(contents[klass]).to be
      end

      it 'gives the object heirarchy from the caller up to BasicObject' do
        ancestors = [
          Object,
          PP::ObjectMixin,
          Kernel,
          BasicObject
        ]

        expect(contents[klass][:ancestors]).to eq ancestors
      end
    end

    context 'on instances' do
      let(:klass){ class Foo; include Introspect; end }
      let(:instance){ klass.new }
      let(:contents){ instance.introspect }

      it 'gives the object class' do
        expect(contents[instance]).to respond_to(:[])
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

        expect(contents[instance][:ancestors]).to eq ancestors
      end
    end
  end
end
