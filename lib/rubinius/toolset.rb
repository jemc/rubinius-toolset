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
      map[name] = ts
      const_set name.capitalize.to_sym, ts
    end

    def self.get(name)
      map[name]
    end
  end
end
