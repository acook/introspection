require_relative 'spec_helper'
require 'introspect/which'

describe Introspect::Which do
  describe '#which' do
    context 'when method defined on eigenclass' do
      subject(:obj) do
        foo = Object.new
        def foo.bar; end
        foo.extend Introspect::Which
        foo
      end

      let(:eigenclass){ class << obj; self; end }

      it 'finds the method' do
        expect(obj.which :bar).to be
      end

      it 'finds the eigenclass' do
        expect(obj.which :bar).to eq eigenclass
      end
    end
  end
end
