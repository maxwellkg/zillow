module Zillow
  module Models
    class RentZestimate
      extend Zillow::Inflector

      # Rent Zestimates do not have their own API call, and therefore should only be
      # instantiated through:
      #   1. Results from a call to the GetZestimate API with parameter rentzestimate set to true
      #   2. Results from a call to the GetDeepSearchResults API with parameter rentzestimate set to true
      #   3. Results from a call to the GetSearchResults API with parameter rentzestimate set to true
      #
      # Given the above, Rent Zestimates may also be included in objects of belonging to
      # Zillow::Models::Property, Zillow::Models::Zestimate, and Zillow::Api::GetDeepSearchResults


      def initialize(attrs)
        attrs.each do |att, val|
          self.class_eval { attr_reader att.rubify }
          self.instance_variable_set("@#{att.rubify}", val)
        end
      end

      def find(zpid)
        Zillow::Models::Zestimate.where(zpid: zpid, rentzestimate: true).rent_zestimate
      end

    end
  end
end
