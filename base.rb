module ZillowApi
  class Base

    def attributes
      atts = {}
      self.instance_variables.each { |v| atts[v.to_s.gsub('@','')] = self.instance_variable_get(v) }
      atts
    end

  end
end
