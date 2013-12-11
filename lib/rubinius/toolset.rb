require "rubinius/toolset/version"

module Rubinius
  module ToolSet
    # Access the current toolset module
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
  end
end
