module ZillowApi
  class Zestimate

    def initialize(attrs)
      attrs.each do |k,v|
        self.class_eval { attr_reader k }
        self.instance_variable_set("@#{k}", v)
      end
    end

  end
end