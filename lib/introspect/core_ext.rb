require 'introspect'
require 'introspect/which'

Object.send :include, Introspect
Object.send :include, Introspect::Which
