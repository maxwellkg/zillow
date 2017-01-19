module ZillowApi
  class Zestimate < Base
    @path = 'GetZestimate'

    @valid_params = {
      :zpid => {:required => true},
      :count => {:required => true},
      :rentzestimate => {:required => false}
    }

    # Zestimates can either be instantiated through:
    #   1. A call to the GetZestimate ZPI (ZillowApi::Zestimate)
    #   2. A call to the DeepSearchResults API (ZillowApi::DeepSearch)
    #
    # Zestimates can also be associated with an object of class
    # ZillowApi::Property (because objects of this class require a
    # a DeepSearch to be performed in their instantiation)

    def initialize(attrs)
      attrs.each do |k,v|
        self.class_eval { attr_reader k }
        self.instance_variable_set("@#{k}", v)
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
    # ZillowApi::Zestimate.where(zpid: '48749425', count: 10, rentzestimate: true)

    def self.where(options)
      validate_options(options)


    end

    private

      def self.validate_options(options)
        required_params = @valid_params.select { |k,v| k if v[:required] == true }.keys

        if required_params.any? { |p| !options.include?(p) }
          raise "Please specify the required params: #{required_params.join(', ')}"
        end

        if options.any? { |opt| !@valid_params.include?(opt) }
          raise "Options (#{options}) include invalid parameters"
        end
      end

  end
end