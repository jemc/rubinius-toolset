# Rubinius::Toolset

Rubinius::ToolSet provides a registry for code tools. These include
the Rubinius bytecode compiler and parser. These, in turn, depend on
other components like the AST and bytecode emitter and serializer.

ToolSets provide a mechanism for other languages to reuse as much of
the Rubinius code tools as are suitable for that language.

## Installation

Add this line to your application's Gemfile:

    gem 'rubinius-toolset'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rubinius-toolset

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
