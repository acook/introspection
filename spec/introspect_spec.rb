require_relative 'spec_helper'
require 'introspect'

describe Introspect do
  specify { expect(Introspect).to be_a Module }

  specify 'classes that include it get an "introspect" method'  do
    class ClassThatIncludesIntrospect; include Introspect; end
    expect(ClassThatIncludesIntrospect.new).to respond_to :introspect
  end
end
