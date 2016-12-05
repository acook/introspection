Introspect
==========

Tools for exploring Ruby's objects!

Basic Usage
-----------

```ruby
require 'introspect/core_ext'  # the core extensions are OPTIONAL but handy
my_object.introspect
```

Tools Available
---------------

### CONTENTS

Tells you all about the object and the objects inside it.

```ruby
require 'introspect'
Introspect.introspect my_object, :contents
```

example

```ruby
[1,2,3].introspect :contents
```

output

```ruby
{
  [1, 2, 3]=>
    {
      :class=>Array,
        :ancestors=>
          [
            Array,
            Enumerable,
            Object,
            PP::ObjectMixin,
            Introspect::Which,
            Introspect,
            Kernel,
            BasicObject
          ]
    }
}
```



### WHICH

Tells you which object a method is defined on.

```ruby
require 'introspect'
Introspect.introspect my_object, :which, :method_name
```

example

```ruby
[1,2,3].introspect :which, :cycle
```
output

```ruby
Array
```

Contributing
------------

Bug reports and pull requests are welcome on GitHub at https://github.com/acook/introspection.

> © Anthony M. Cook 2012-2016
