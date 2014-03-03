require "rubinius/toolset/version"

module Rubinius
  module ToolSets
    # Returns the module enclosing the current toolset.
    def self.current
      @current ||= Module.new
    end

    # Start a new toolset module by clearing out the current one
    def self.start
      @current = nil
    end

    # Set the current toolset module as a constant on Rubinius::ToolSets
    def self.attach(name)
      current.const_set :ToolSet, current
      return unless name

      name = name.to_s.split("_").map { |x| x.capitalize }.join
      const_set name, current
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
