module ZillowApi
  class DeepSearch
    @path = 'GetDeepSearchResults'

    attr_accessor :criteria
    attr_reader :results

    def initialize

    end

    def execute
      @results = Request.new(path: @path, options: criteria).execute.response['searchresults']['response']['results']
    end

    def loaded?
      @loaded == true
    end

    def load
      execute unless loaded?
    end

  end
end
