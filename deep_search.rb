module ZillowApi
  class DeepSearch
    @path = 'GetDeepSearchResults'

    attr_accessor :criteria
    attr_reader :result

    def initialize(criteria)
      @criteria = criteria
      @loaded = false
    end

    def execute
      @result = Request.new(path: self.class.instance_variable_get('@path'), options: criteria).execute['searchresults']['response']['results']['result']
      @loaded = true

      @result
    end

    def zpid
      @results['zpid']
    end

    def loaded?
      @loaded == true
    end

    def load
      execute unless loaded?
    end

  end
end
