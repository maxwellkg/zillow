module ZillowApi
  class RentZestimate

    # Rent Zestimates do not have their own API call, and therefore should only be
    # instantiated through:
    #   1. Results from a call to the GetZestimate API with parameter rentzestimate set to true
    #   2. Results from a call to the GetDeepSearchResults API with parameter rentzestimate set to true
    #
    # Given the above, Rent Zestimates may also be included in objects of belonging to
    # ZillowApi::Property, ZillowApi::Zestimate, and ZillowApi::DeepSearch


    def initialize(attrs)

    end

    def find(zpid)

    end

    
  end
end
