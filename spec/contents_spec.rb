require_relative 'spec_helper'
require 'introspect'

describe Introspect::Contents do
  describe '#contents' do
    let(:klass){ Class.new }

    context 'on classes' do
      let(:contents){ Introspect::Contents.contents klass }

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
      let(:instance){ klass.new }
      let(:contents){ Introspect::Contents.contents instance }

      it 'gives the object class' do
        expect(contents[instance]).to respond_to(:[])
      end

      it 'gives the object heirarchy from the caller up to BasicObject' do
        ancestors = [
          klass,
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
