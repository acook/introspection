require_relative 'spec_helper'
require 'introspect/which'

describe Introspect::Which do
  describe '.which' do
    let(:obj){ ::IO }

    it 'finds methods' do
      expect(described_class.which obj, :puts).to eq obj
    end
  end

  describe '#which' do
    subject(:which){ Introspect::Which.new obj }

    context 'method defined on eigenclass' do
      let(:obj){ Object.new.tap{ |o| def o.foo; end } }
      let(:eigenklass){ class << obj; self; end }

      it 'finds the method' do
        expect(which.which :foo).to be
      end

      it 'finds the eigenclass' do
        expect(which.which :foo).to eq eigenklass
      end
    end

    context 'method defined on class' do
      let(:obj){ klass.new }
      let(:klass){ Class.new.tap{|o| o.module_eval{ def foo; end } } }

      it 'returns the class' do
        expect(which.which :foo).to eq klass
      end
    end

    context 'method defined on superclass' do
      let(:obj){ klass.new }
      let(:klass){ Class.new superklass }
      let(:superklass){ Class.new.tap{|o| o.module_eval{ def foo; end } } }

      it 'returns the superclass' do
        expect(which.which :foo).to eq superklass
      end
    end
  end
end
