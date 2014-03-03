# Rubinius::Toolsets

Rubinius::ToolSets provides a registry for code tools.

The goal of ToolSets is to provide a mechanism for sharing as much as possible
between the Rubinius build tools (e.g. the parser, the AST, tools to operate
on bytecode) and custom build tools for specific tasks or for other languages
targeting Rubinius.

## Installation

Add this line to your application's Gemfile:

    gem 'rubinius-toolset'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubinius-toolset

## Usage

There are two operations on ToolSets:

1. Creating a new ToolSet.
2. Accessing the current ToolSet.

Create a new ToolSet before defining or loading the classes and modules that
implement code tools. Access the current ToolSet to build up its various parts
as a consistent whole.

To define a ToolSet in separate pieces, use the following example:

```ruby
# my_code_tools.rb
# Entry point to defining MyCodeTools
Rubinius::ToolSets.create :my_code_tools

# my_code_tools/some_tool.rb
module Rubinius::ToolSets.current::ToolSet
  # define a tool
end
```

Alternatively, define a ToolSet by requiring files in a block as follows:

```ruby
Rubinius::ToolSets.create :my_code_tools do
  require "my_code_tools"
end
```

The advantage of the latter approach is that multiple ToolSets can be created
from some of the same files because `$LOADED_FEATURES` are reset when yielding
to the block.

## Reference

### Rubinius::ToolSets.create([name [, &block]])

Creates a new ToolSet.

If name is not given, the ToolSet is not assigned to a constant under
`Rubinius::ToolSets`. If the name is given, it is camelized and set as a
constant under Rubinius::ToolSets.

If a block is passed, `$LOADED_FEATURES` is cleared before yielding to the
block and reset afterwards. The ToolSet is yielded to the block.

Calling `Rubinius::ToolSet.create` a second time creates a new ToolSet.

### Rubinius::ToolSets.current

Returns the ToolSet that is being defined. If called before `.create`, a new,
anonymous ToolSet is created.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
