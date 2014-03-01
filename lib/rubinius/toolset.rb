require "rubinius/toolset/version"

module Rubinius
  module ToolSet
    # Returns the module enclosing the current toolset.
    def self.current
      @current ||= Module.new
    end

    # Start a new toolset module by clearing out the current one
    def self.start
      @current = nil
    end

    # Access the Hash containing the finished toolset modules
    def self.map
      @map ||= {}
    end

    # Finish the current toolset module by registering it with a name
    def self.finish(name)
      ts = current::TS
      ts.const_set :ToolSet, ts
      map[name] = ts
      const_set name.to_s.capitalize.to_sym, ts
    end

    # Get a finished toolset module by name
    def self.get(name)
      map[name]
    end

    # Set the current toolset module as a constant on Rubinius::ToolSet
    def self.attach(name)
      return unless name

      map[name] = current

      name = name.to_s.split("_").map { |x| x.capitalize }.join
      const_set name, current

      current.const_set :TS, current
      current::TS.const_set :ToolSet, current
    end

    # Create a new toolset, optionally with a name. The module enclosing the
    # toolset yielded to the block.
    def self.create(name=nil)
      loaded_features = $LOADED_FEATURES
      $LOADED_FEATURES.clear

      start
      attach name

      yield current
    ensure
      $LOADED_FEATURES.replace loaded_features
    end
  end
end
