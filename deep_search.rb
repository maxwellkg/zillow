module ZillowApi
  class DeepSearch < Base
    @path = 'GetDeepSearchResults'

    attr_accessor :criteria
    attr_reader :result

    # Retrieve details based on a particular address
    #
    # Documentation for the Zillow GetDeepSearchResults API can be found here:
    # http://www.zillow.com/howto/api/GetDeepSearchResults.htm
    #

    # Criteria can include the following:
    # +address+:: The address of the property to search. This string should be URL encoded.
    # +citystatezip+:: The city+state combination and/or ZIP code for which to search. This string should be URL encoded. Note that giving both city and state is required. Using just one will not work.
    # +rentzestimage+:: Return Rent Zestimate information if available (boolean true/false, default: false)

    def initialize(criteria)
      @criteria = criteria
      @loaded = false
    end

    def execute
      @result = Request.new(path: self.class.instance_variable_get('@path'), options: criteria).execute['searchresults']['response']['results']['result']
      @loaded = true

      @result
    end

    def loaded?
      @loaded == true
    end

    def load
      execute unless loaded?
    end

    def zpid
      @results['zpid']
    end

  end
end
