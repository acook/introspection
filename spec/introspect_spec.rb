require_relative 'spec_helper'
require 'introspect'

describe Introspect do
  specify { expect(Introspect).to be_a Module }

  context 'when included on a class' do
    subject(:klass){ Class.new.tap{|o| o.send :include, Introspect } }

    it 'gets an "introspect" method'  do
      expect(klass.new).to respond_to :introspect
    end

    it 'returns the contents of an object' do
      expect(klass.new.introspect :contents).to be_a Hash
    end
  end

  context 'when extending an instance' do
    subject(:obj){ Array.new.tap{|a| a.extend Introspect } }

    it 'gets an "introspect" method'  do
      expect(obj).to respond_to :introspect
    end

    it 'finds where methods are defined' do
      expect(obj.introspect :which, :fill).to eq Array
    end
  end
end
