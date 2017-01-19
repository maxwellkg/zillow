module ZillowApi
  class Request

    BASE = "http://www.zillow.com/webservice"

    CREDENTIALS = {
      :zwsid => 'X1-ZWz19emx3ram17_4ye7m'
      }.freeze

    attr_accessor :path, :options
    attr_reader :response

    def initialize(path: nil, options: {})
      @path, @options = path, options
    end

    # Generate the url for the request

    # @param [String] path, the web service name
    # @param [Hash] options, additional request options

    def uri
      opts = URI.encode_www_form(options)
      URI("#{BASE}/#{@path}.htm?zws-id=#{CREDENTIALS[:zwsid]}&#{opts}")
    end

    # Executes the request

    def execute
      res = Net::HTTP.get_response(uri)
      if res.is_a?(Net::HTTPSuccess)
        @response = Hash.from_xml(res.body)
      else
        raise "#{res.code}: #{JSON.parse(res.body)}"
      end
    end

  end
end

'http://www.zillow.com/webservice/.htm?zws-id=X1-ZWz19emx3ram17_4ye7m&address=2114+Bigelow+Ave&citystatezip=Seattle+WA
'http://www.zillow.com/webservice/GetDeepSearchResults.htm?zws-id=X1-ZWz19emx3ram17_4ye7m&address=2114+Bigelow+Ave&citystatezip=Seattle+WA'