module ZillowApi
  class Zestimate

    # Zestimates can either be instantiated through:
    #   1. A call to the GetZestimate ZPI (ZillowApi::Zestimate)
    #   2. A call to the DeepSearchResults API (ZillowApi::DeepSearch)
    #   3. Instantiation of an instance of ZillowApi::Property
    #
    # Zestimates can also be associated with an object of class
    # ZillowApi::Property (because objects of this class require a
    # a DeepSearch to be performed in their instantiation)
    #
    # Instances of ZillowApi::Zestimate may or may not have a corresponding
    # instance of ZillowApi::RentZestimate

    def initialize(attrs)
      attrs.each do |k,v|
        if k == 'zestimate'
          v.each do |att, val|
            set_readers(att, val)
          end
        else
          set_readers(k,v)
        end
      end
    end

    # Find a Zestimate from the property's Zillow Property ID
    #
    # Params:
    # +zpid+:: The Zillow Property ID for the property for which to obtain information; the parameter type is an integer
    # +count+:: The number of comparable recent sales to obtain (integer between 1 and 25)
    # +rentzestimate+:: Return Rent Zestimate information if available (boolean true/false, default: false)
    #
    # @example
    # ZillowApi::Zestimate.where(zpid: '48749425')
    # ZillowApi::Zestimate.where(zpid: '48749425', rentzestimate: true)

    def self.where(options)
      self.new(ZillowApi::Api::Calls::GetZestimate.new(options).execute['zestimate']['response'])
    end

    private

      def set_readers(att, value)
        self.class_eval { attr_reader att.rubify }
        self.instance_variable_set("@#{att.rubify}", value)
      end

  end
end