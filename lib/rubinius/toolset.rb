require "rubinius/toolset/version"

module Rubinius
  module ToolSet
    def self.current
      @current ||= Module.new
    end

    def self.start
      @current = nil
    end

    def self.map
      @map ||= {}
    end

    def self.finish(name)
      ts = current::TS
      ts.const_set :ToolSet, ts
      map[name] = ts
      const_set name.to_s.capitalize.to_sym, ts
    end

    def self.get(name)
      map[name]
    end

    def self.create
      loaded_features = $LOADED_FEATURES
      $LOADED_FEATURES.clear
      yield
    ensure
      $LOADED_FEATURES.replace loaded_features
    end
  end
end
