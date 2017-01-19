module ZillowApi
  module Inflector

    String.send(:include, self)
    Symbol.send(:include, self)

    def rubify
      case self
      when Symbol
        to_s.rubify
      when String
        underscore
      end
    end

  end
end