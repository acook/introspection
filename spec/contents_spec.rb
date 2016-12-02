require_relative 'spec_helper'
require 'introspect'

describe Introspect::Contents do
  describe '#contents' do
    let(:klass){ Class.new }
    let(:expected_ancestors){ [Object, PP::ObjectMixin, Kernel, BasicObject] }

    context 'on classes' do
      let(:contents){ Introspect::Contents.contents klass }

      it 'stores the class as the key' do
        expect(contents.keys).to include klass
      end

      describe :ancestors do
        it 'gives the object hierarchy from the caller up to BasicObject' do
          expect(contents[klass][:ancestors]).to eq expected_ancestors
        end
      end
    end

    context 'on instances' do
      let(:instance){ klass.new }
      let(:contents){ Introspect::Contents.contents instance }

      it 'stores the object as the key' do
        expect(contents.keys).to include instance
      end

      describe :ancestors do
        it 'gives the object hierarchy from the caller up to BasicObject' do
          expect(contents[instance][:ancestors]).to eq expected_ancestors.unshift(klass)
        end
      end
    end
  end
end
